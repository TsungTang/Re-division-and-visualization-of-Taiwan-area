library(data.table)
library(pipeR)
library(stringr)
library(rgdal) # readOGR
library(rgeos) # gCentroid
library(SPODT) # spatial partitioning
# install.packages('rgeos')
library(maptools) # unionSpatialPolygons
library(leaflet)
library( rmapshaper) # ms_simplify
library(RColorBrewer)
library(htmlwidgets) # saveWidget
# library(sp) # proj4string, spTransform

#### data
# https://data.gov.tw/dataset/7441
town.ori <- readOGR('TOWN_MOI_1070516', 'TOWN_MOI_1070516', encoding = 'UTF-8', use_iconv = T)
town.main <- town.ori[!town.ori$COUNTYNAME %in% c('連江縣', '金門縣', '澎湖縣'),]

# https://data.gov.tw/dataset/37759
zip <- fread('data/外部資料/zip.csv' , encoding = 'UTF-8')

# 變遷
demography <- readRDS("data/rdsfile/demography.df.pca.rds")
ST <- readRDS('data/rdsfile/ST.df.pca.rds')
life <- readRDS('data/rdsfile/life2.df.pca.rds')

demography <- copy(demography@data) %>>% setDT
ST <- copy(ST@data) %>>% setDT
life <- copy(life@data) %>>% setDT

# map
county.s <- readRDS('data/rdsfile/county.s.rds')

####
names(demography)[c(9, 10, 14)] <- c('folk', 'non', 'cluster.demo')
names(ST)[8] <- 'cluster.ST'
names(life)[6] <- 'cluster.life'

demography <- demography[, -c('south', 'town.name')]
ST <- ST[, -c('south', 'town.name')]
life <- life[, -c('south', 'town.name')]

setnames(demography, paste0('pca', 1:3), paste0('demo.pca', 1:3))
setnames(ST, 'pca1', 'ST.pca1')
setnames(life, paste0('pca', 1:2), paste0('life.pca', 1:2))

#### zip
# zip[, TOWNCODE := str_pad(TOWNCODE, width = 7, side = 'left', pad = 0) %>>% paste0('0')]
# TOWNCODE對不上
zip <- zip[, unique.ID := paste0(COUNTYID, TOWNNAME)]
zip <- zip[, .(unique.ID, ZIPCODE)]

#### merge same zipcode town
town.DT <- copy(town.main@data) %>>% setDT
write.csv(town.DT, 'data/town.DT.csv', row.names = F, fileEncoding = 'UTF-8')
town.DT <- fread('data/town.DT.csv', encoding = 'UTF-8')
town.DT[, TOWNENG := NULL]
# z <- lapply(names(town.DT), function(x) town.DT[, c(x) := get(x) %>>% as.character]) #?
town.DT[, unique.ID := paste0(COUNTYID, TOWNNAME)]

town.DT <- merge(town.DT, zip, by = 'unique.ID', all.x = T, sort = F)
town.DT %>>% setnames('ZIPCODE', 'zip')
town.DT[, unique.ID := NULL]

# 以下兩區用 country code 取代 town code
town.DT[zip == 300, c('TOWNNAME', 'TOWNCODE', 'TOWNID') := list(COUNTYNAME, COUNTYCODE, 'O')]
town.DT[zip == 600, c('TOWNNAME', 'TOWNCODE', 'TOWNID') := list(COUNTYNAME, COUNTYCODE, 'I')]
town.DT[zip == 300]

town.un <- unionSpatialPolygons(town.main, town.DT$zip)

#### 合併變遷資料
town.DT <- town.DT[, unique(.SD)] 

town.DT <- merge(town.DT, demography, by = 'zip', all.x = T, sort = F)
town.DT <- merge(town.DT, ST, by = 'zip', all.x = T, sort = F)
town.DT <- merge(town.DT, life, by = 'zip', all.x = T, sort = F)

# 北中南東官方分類
town.DT[str_detect(COUNTYNAME, paste(c('臺北市', '新北市', '基隆市', '桃園市', '新竹市', '新竹縣', '宜蘭縣'), sep = '', collapse = '|')), ori := 'N']
town.DT[str_detect(COUNTYNAME, paste(c('花蓮縣', '臺東縣'), sep = '', collapse = '|')), ori := 'E']
town.DT[str_detect(COUNTYNAME, paste(c('嘉義市', '嘉義縣', '臺南市', '高雄市', '屏東縣', '澎湖縣'), sep = '', collapse = '|')), ori := 'S']
town.DT[str_detect(COUNTYNAME, paste(c('苗栗縣', '臺中市', '彰化縣', '南投縣', '雲林縣'), sep = '', collapse = '|')), ori := 'M']

# town.DT[is.na(ori), COUNTYNAME %>>% unique]

town.DT <- town.DT[order(zip)]
row.names(town.DT) <- town.DT$zip

town <- SpatialPolygonsDataFrame(town.un, town.DT, match.ID = T)

#### simplify
town.s <- copy(town)
town.s@data[, TOWNNAME := NULL]
town.s@data[, COUNTYNAME := NULL]
town.s <- ms_simplify(town.s, keep = 0.05, keep_shapes = T)  # ID 跑掉了???
for (i in 1:length(town.s@polygons) ) {
  town.s@polygons[[i]]@ID = town@polygons[[i]]@ID 
}
town.s <- SpatialPolygonsDataFrame(town.s, town.DT, match.ID = T)

#### output
saveRDS(town, 'data/rdsfile/map/town.sp.rds')
saveRDS(town.s, 'data/rdsfile/map/town.s.sp.rds')
saveRDS(town.DT, 'data/rdsfile/map/town.DT.rds')

#### polygons to points 算每一區的中心
town.point.s <- SpatialPointsDataFrame(gCentroid(town, byid = T), town@data, match.ID = T)
# proj4string(town.point) <- '+proj=longlat +datum=WGS84 +ellps=WGS84'
town.point <- spTransform(town.point.s, CRS('+proj=merc +datum=WGS84 +ellps=WGS84'))

#### start partitioning!
spodt.fun <- function(x, y, graft = 0.1, min.child = 15) {
  # for1 <<- names(get(x))[-length(get(x))][-1] %>>% 
  #   paste(collapse = '+') %>>% paste0('~ 1') # 不知為何必須要global才能用?
  for1 <<- paste0(x, '~ 1')
  
  spodt.1 <- spodt(formula(for1), town.point[!is.na(town.point[[y]]),],
                   graft = graft, level.max = 100, min.parent = 25, min.child = min.child, rtwo.min = 0.01)
  
  spodt.L.1 <- spodtSpatialLines(spodt.1, town.point[!is.na(town.point[[y]]),])
  
  output <- list()
  output$partition <- spodt.1@partition
  output$line <- spodt.L.1
  
  return(output)
}

# x = 'life.pca1'
# y=  'cluster.life'
# spodt.1@partition %>>% unique %>>% length
# 
# test <- spodt.fun('life.pca1', 'cluster.life', graft = 0)
# test$partition %>>% unique

####
from.data <- c('demography', 'ST', 'life')
short.name <- c('demo', 'ST', 'life')
line.list <- list()
part <- c()

for ( i in seq(from.data) ) {
  cat('\n\n\n','data:: ',i,"\n")
  pca.cols <- names(town.DT) %>>% str_extract(paste0(short.name[i], '.pca.')) %>>% na.exclude()
  for ( k in pca.cols) {
    cat('pca column:: ' , k ,'\n')
    last.part = 9999
    for ( j in seq(0, 0.5, 0.001) ) {
      cat('graft' , j ,'\n')
      cluster.name <- paste0('cluster.', short.name[i])
      
      spodt.result <- spodt.fun(k, cluster.name, graft = j)
      
      new.part <- spodt.result$partition %>>% unique %>>% length
      
      if ( new.part < last.part ) {
        
        new.col <- paste0(k, '_', new.part)
        part <- c(part, new.col)
        town.DT[!is.na(get(cluster.name)), c(new.col) := spodt.result$partition]
        
        line.list[[paste0(k, '_', new.part)]] <- spTransform(spodt.result$line, CRS('+proj=longlat +datum=WGS84'))
        
        last.part <- new.part
      }
      if (last.part == 2) break
    }
  }
}

####
row.names(town.DT) <- town.DT$zip
town.s <- SpatialPolygonsDataFrame(town.s, town.DT, match.ID = T)


#### output
# saveRDS(town.s, 'data/rdsfile/map/twon.s.rds')
# saveRDS(town.DT, 'town.DT.1.rds')

####
# factor顏色
col.factor <- function(domain = NULL, n = 10, palette = "Set3", type = "map") {
  out = colorFactor(palette, domain, na.color = "#999999")
  if (type == "map") {
    return(out(domain))
  } else if (type == "legend color") {
    return(brewer.pal(n, palette))
  }
}

#### map
m <- leaflet(options = leafletOptions(minZoom = 7, maxZoom = 10)) %>% # 設定zoom範圍
  addProviderTiles("Stamen.Toner") %>>%
  setView(120.5825975, 23.583234, zoom = 8) %>% # 定位
  # addTiles(urlTemplate = "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga", group = "google map") %>% # 底圖，google
  addPolygons(data = county.s, weight = 3, color = 'brown', opacity = 0.8,
              fill = F, group = 'county') %>% # county
  addPolygons(data = town.s, weight = 1, color = 'gray', 
              fill = T, fillOpacity = 1, 
              fillColor = ~col.factor(ori, palette = 'Paired'), 
              popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>"),
              group = 'original') # original
# addCircles(data = town.point.s, radius = 1000, stroke = F,
# fillColor = 'purple', fillOpacity = 0.8, group = 'town (point)') # Town point

# clustring
m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                       fill = T, fillOpacity = 1, 
                       fillColor = ~col.factor(cluster.demo, palette = 'Paired'), 
                       popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                       "<br>group :", cluster.demo , "</b>"  ,
                                       '<br>' ,'occI :' ,  round(occI,3), '</b>' ,
                                       '<br>' ,'hakka :' ,  round(hakka,3), '</b>' ,
                                       '<br>' ,'aboriginal :' ,  round(aboriginal,3), '</b>' ,
                                       '<br>' ,'mainland :' ,  round(mainland,3), '</b>' ,
                                       '<br>' ,'elder :' ,  round(elder,3), '</b>' ,
                                       '<br>' ,'buddhism :' ,  round(buddhism,3), '</b>' ,
                                       '<br>' ,'christianity :' ,  round(christianity,3), '</b>' ,
                                       '<br>' ,'folk :' ,  round(folk,3), '</b>' ,
                                       '<br>' ,'non :' ,  round(non,3), '</b>' ,
                                       '<br>' ,'taoism :' ,  round(taoism,3), '</b>' ,
                                       '<br>' ,'female :' ,  round(female,3), '</b>' 
                       ) , group = 'Clustering by demo') 

m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                       fill = T, fillOpacity = 1, 
                       fillColor = ~col.factor(cluster.ST, palette = 'Paired'), 
                       popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                       "<br>group :", cluster.ST , "</b>"  ,
                                       '<br>' ,'college :' , round(college,3) , '</b>' ,
                                       '<br>' ,'income :' ,  round(income,3) , '</b>' ,
                                       '<br>' ,'occp :' ,  round(occp,3) , '</b>' ,
                                       '<br>' ,'ses :' ,  round(ses,3), '</b>' ,
                                       '<br>' ,'ses5 :' ,  round(ses5,3), '</b>' 
                       ) ,
                       group = 'Clustering by ST')

m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                       fill = T, fillOpacity = 1, 
                       fillColor = ~col.factor(cluster.life, palette = 'Paired'), 
                       popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                       "<br>group :", cluster.life , "</b>"  ,
                                       '<br>' ,'unhealth :' ,  round(unhealth,3) , '</b>' ,
                                       '<br>' ,'unhappy :' ,  round(unhappy,3), '</b>' ,
                                       '<br>' ,'unsatisfaction :' ,  round(unsatisfaction,3) , '</b>' 
                       ) ,
                       group =  'Clustering by life') 
  
  
                       

# spatial
for ( i in c(part) ) {
  if(str_detect(i , 'demo')){
    m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                           fill = T, fillOpacity = 1, 
                           fillColor = ~col.factor(get(i), palette = 'Paired'), 
                           popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                           "<br>group :", get(i) , "</b>"  ,
                                           '<br>',str_extract(i , "[^_]+") ,' :' , get(str_extract(i , "[^_]+")) , '</b>' ,
                                           '<br>' ,'occI :' ,  round(occI,3), '</b>' ,
                                           '<br>' ,'hakka :' ,  round(hakka,3), '</b>' ,
                                           '<br>' ,'aboriginal :' ,  round(aboriginal,3), '</b>' ,
                                           '<br>' ,'mainland :' ,  round(mainland,3), '</b>' ,
                                           '<br>' ,'elder :' ,  round(elder,3), '</b>' ,
                                           '<br>' ,'buddhism :' ,  round(buddhism,3), '</b>' ,
                                           '<br>' ,'christianity :' ,  round(christianity,3), '</b>' ,
                                           '<br>' ,'folk :' ,  round(folk,3), '</b>' ,
                                           '<br>' ,'non :' ,  round(non,3), '</b>' ,
                                           '<br>' ,'taoism :' ,  round(taoism,3), '</b>' ,
                                           '<br>' ,'female :' ,  round(female,3), '</b>' 
                                           ) ,
                           group = i) %>% # Town
      addPolylines(data = line.list[[i]], weight = 3, color = 'red', opacity = 1, group = i) # line
  }else if(str_detect(i , 'ST') ) {
    m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                           fill = T, fillOpacity = 1, 
                           fillColor = ~col.factor(get(i), palette = 'Paired'), 
                           popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                           "<br>group :", get(i) , "</b>"  ,
                                           '<br>',str_extract(i , "[^_]+") ,' :' , get(str_extract(i , "[^_]+")) , '</b>' ,
                                           '<br>' ,'college :' , round(college,3) , '</b>' ,
                                           '<br>' ,'income :' ,  round(income,3) , '</b>' ,
                                           '<br>' ,'occp :' ,  round(occp,3) , '</b>' ,
                                           '<br>' ,'ses :' ,  round(ses,3), '</b>' ,
                                           '<br>' ,'ses5 :' ,  round(ses5,3), '</b>' 
                                           ) ,
                           group = i) %>% # Town
      addPolylines(data = line.list[[i]], weight = 3, color = 'red', opacity = 1, group = i) # line
  }else if(str_detect(i , 'life')){
    m <- m %>% addPolygons(data = town.s, weight = 1, color = 'gray', 
                           fill = T, fillOpacity = 1, 
                           fillColor = ~col.factor(get(i), palette = 'Paired'), 
                           popup = ~ paste("<b>", zip, COUNTYNAME, TOWNNAME, "</b>",
                                           "<br>group :", get(i) , "</b>"  ,
                                           '<br>',str_extract(i , "[^_]+") ,' :' , get(str_extract(i , "[^_]+")) , '</b>' ,
                                           '<br>' ,'unhealth :' ,  round(unhealth,3) , '</b>' ,
                                           '<br>' ,'unhappy :' ,  round(unhappy,3), '</b>' ,
                                           '<br>' ,'unsatisfaction :' ,  round(unsatisfaction,3) , '</b>' 
                                           ) ,
                           group = i) %>% # Town
      addPolylines(data = line.list[[i]], weight = 3, color = 'red', opacity = 1, group = i) # line
  }
}

show <- c('county')
hide <- c('original', 'Clustering by demo','Clustering by ST','Clustering by life', part)

m <- m %>%
  addLayersControl(
    # baseGroups = c("google map", "country"),
    overlayGroups = c(show, hide),
    options = layersControlOptions(collapsed = F)) %>% 
  hideGroup(hide)

# m

saveWidget(m, file="map.html", selfcontained = F)
browseURL("map.html")

