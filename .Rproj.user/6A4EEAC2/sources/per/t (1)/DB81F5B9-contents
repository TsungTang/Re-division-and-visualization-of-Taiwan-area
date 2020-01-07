
# town.zip[,south:=ifelse((zip >= 600 & zip <= 885)|(zip >= 900 & zip <= 947 ) , 1 , ifelse(is.na(zip) , NA ,0))]
library(ggpubr)
library(pipeR)
library(haven)
library(igraph)
library(useful)
library(stringr)
library("factoextra")
library(maps)
library(cluster)
library(data.table)
library("mclust")
library(nnet)

PCbiplot <- function(PC, x="PC1", y="PC2", colors=c('black', 'black', 'red', 'red')) {
  # PC being a prcomp object
  data <- data.frame(obsnames=row.names(PC$x), PC$x)
  plot <- ggplot(data, aes_string(x="PC1", y="PC2")) + geom_text(alpha=.6, size=3, aes(label=obsnames), color=colors[1])
  # plot <- plot + geom_hline(aes(0), size=.2) + geom_vline(aes(0), size=.2, color=colors[2])
  datapc <- data.frame(varnames=rownames(PC$rotation), PC$rotation)
  mult <- min(
    (max(data[,"PC2"]) - min(data[,"PC2"])/(max(datapc[,"PC2"])-min(datapc[,"PC2"]))),
    (max(data[,"PC1"]) - min(data[,"PC1"])/(max(datapc[,"PC1"])-min(datapc[,"PC1"])))
  )
  datapc <- transform(datapc,
                      v1 = .7 * mult * (get("PC1")),
                      v2 = .7 * mult * (get("PC2"))
  )
  plot <- plot + coord_equal() + geom_text(data=datapc, aes(x=v1, y=v2, label=varnames), size = 10, vjust=1, color=colors[3])
  plot <- plot + geom_segment(data=datapc, aes(x=0, y=0, xend=v1, yend=v2), arrow=arrow(length=unit(0.4,"cm")), alpha=0.75, color=colors[4]) + theme(text = element_text(size=40))
  plot
}

demography.dt = readRDS('data/rdsfile/demography.dt.rds')
ST.dt = readRDS('data/rdsfile/ST.dt.rds')
life2.dt = readRDS('data/rdsfile/life2.dt.rds')
#---------------------------- kmean --------------------------------------#

# demography
#standardlization
# x = demography.dt[,lapply(.SD, function(x) psycho::standardize(x)) ,.SDcols = names(demography.dt[,2:12])]

# optima cut
# kmean.best = FitKMeans(demography.dt[,2:12] , max.clusters = 8 , nstart = 25 ,seed =2001)
# PlotHartigan(kmean.best)
# optimal 1
fviz_nbclust(demography.dt[,2:12], kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)
# optimal 2
x=fviz_nbclust(demography.dt[,2:12], kmeans, method = "silhouette")
optimal.cut = as.numeric(x$data[which.max(x$data$y),]$clusters)

kmeans.cluster <- kmeans(demography.dt[,2:12], centers=optimal.cut , nstart = 20) 
demography.dt[,kmeanclu.4 := kmeans.cluster$cluster]

fisher.test(demography.dt$kmeanclu.4 ,demography.dt$south)
chisq.test(demography.dt$kmeanclu.4 ,demography.dt$south)
with(demography.dt , table(kmeanclu.4 , south))
# 補充
fviz_cluster(kmeans.cluster, data = demography.dt[,2:12], geom = "point",
             stand = FALSE, frame.type = "norm")



##-------------------- social stratification -------------------------------------------------------##
kmean.best = FitKMeans(ST.dt[,2:6] , max.clusters = 10 , nstart = 25 ,seed =2001)
PlotHartigan(kmean.best)

fviz_nbclust(ST.dt[,2:6], kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)
# optimal 2
x=fviz_nbclust(ST.dt[,2:6], kmeans, method = "silhouette")
optimal.cut = as.numeric(x$data[which.max(x$data$y),]$clusters)

kmeans.cluster <- kmeans(ST.dt[,2:6], centers=optimal.cut , nstart = 20)
ST.dt[,kmeanclu.3 := kmeans.cluster$cluster]

fisher.test(ST.dt$kmeanclu.3 ,ST.dt$south)
chisq.test(ST.dt$kmeanclu.3 ,ST.dt$south)
with(ST.dt , table(kmeanclu.3 , south))




#------------------------ life status---------------------------------------#
# life.dt = na.omit(life.dt)
# kmean.best = FitKMeans(life.dt[,2:4] , max.clusters = 10 , nstart = 25 ,seed =2001)
# PlotHartigan(kmean.best)
# 
# fviz_nbclust(life.dt[,2:4], kmeans, method = "wss") +
#   geom_vline(xintercept = 3, linetype = 2)
# # optimal 2
# x=fviz_nbclust(life.dt[,2:4], kmeans, method = "silhouette")
# 
# optimal.cut = as.numeric(x$data[which.max(x$data$y),]$clusters)
# 
# kmeans.cluster <- kmeans(life.dt[,2:4], centers=optimal.cut , nstart = 20)
# life.dt[,kmeanclu.3 := kmeans.cluster$cluster]
# 
# fisher.test(life.dt$kmeanclu.4 ,life.dt$south)

# life status 2
life2.dt = na.omit(life2.dt)
kmean.best = FitKMeans(life2.dt[,2:4] , max.clusters = 10 , nstart = 25 ,seed =2001)
PlotHartigan(kmean.best)

fviz_nbclust(life2.dt[,2:4], kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)
# optimal 2
x=fviz_nbclust(life2.dt[,2:4], kmeans, method = "silhouette")

optimal.cut = as.numeric(x$data[which.max(x$data$y),]$clusters)

kmeans.cluster <- kmeans(life2.dt[,2:4], centers=3 , nstart = 20)
life2.dt[,kmeanclu.3 := kmeans.cluster$cluster]

fisher.test(life2.dt$kmeanclu.3 ,life2.dt$south)

# saveRDS(life.dt ,'data/rdsfile/life.dt.rds')
# saveRDS(life2.dt ,'data/rdsfile/life2.dt.rds')
# 
# saveRDS(ST.dt ,'data/rdsfile/ST.dt.rds')
# saveRDS(demography.dt ,'data/rdsfile/demography.dt.rds')

#-------------------------------------spatial partitioning method---------------------------------------------#
# demography.dt = readRDS('data/rdsfile/demography.dt.rds')
# ST.dt = readRDS('data/rdsfile/ST.dt.rds')
# life2.dt = readRDS('data/rdsfile/life2.dt.rds')

library(SPODT)
demography.dt = merge(demography.dt ,town.zip[,.(zip,town.name,longitude,latitude)])
demography.dt = str.transform(demography.dt , c('longitude','latitude'),as.numeric )
demography.df = as.data.frame(demography.dt)
demography.df= na.omit(demography.df)
names(demography.df)[c(9,10)] = c('folk','non')

coordinates(demography.df) <- c('longitude','latitude')

# pca
pca1 <- prcomp(formula = ~ occI + hakka + aboriginal + mainland + elder +buddhism+christianity+ folk+non +taoism+female,  
              data = demography.df,                           
              scale = TRUE)   
plot(pca1,
     type="line",
     main="Scree Plot for social stratification");abline(h=1, col="blue")
(vars1 <- (pca1$sdev)^2)  # 從pca中取出標準差(pca$sdev)後再平方，計算variance(特徵值)
(props1 <- vars1 / sum(vars1))    
(cumulative.props1 <- cumsum(props1))  # 累加前n個元素的值
pca1$rotation[,1:3]
demography.df$pca1 = pca1$x[,1]
demography.df$pca2 = pca1$x[,2]
demography.df$pca3 = pca1$x[,3]
saveRDS(demography.df , 'data/rdsfile/demography.df.pca.rds')
# pca done

# pca 1
spodt.results1.pca1 <- spodt(pca1 ~ 1, data = demography.df, 
                        graft = 0,
                       level.max = 10, min.parent = 25, min.child =15, rtwo.min = 0.01)
spodt.tree(spodt.results1.pca1)
SSL.result1.pca1 <- spodtSpatialLines(spodt.results1.pca1, demography.df)
# plot(SSL.result1)
# points(demography.df, cex = log(demography.df$folk *10 ))

# pca 2
spodt.results1.pca2 <- spodt(pca2 ~ 1, data = demography.df, 
                        graft = 0,
                        level.max = 10, min.parent = 25, min.child =15, rtwo.min = 0.01)
spodt.tree(spodt.results1.pca2)
SSL.result1.pca2 <- spodtSpatialLines(spodt.results1.pca2, demography.df)
# pca 3
spodt.results1.pca3 <- spodt(pca3 ~ 1, data = demography.df, 
                        graft = 0,
                        level.max = 10, min.parent = 25, min.child =15, rtwo.min = 0.01)
spodt.tree(spodt.results1.pca3)
SSL.result1.pca3 <- spodtSpatialLines(spodt.results1.pca3, demography.df)

# cbind(demography.df$town.name , spodt.results1@partition)
demography.dt[,sp.g0.chi15.pca1:=spodt.results1.pca1@partition]
demography.dt[,sp.g0.chi15.pca2:=spodt.results1.pca2@partition]
demography.dt[,sp.g0.chi15.pca3:=spodt.results1.pca3@partition]

demography.dt[,lapply(.SD, mean) , by = 'sp.g0.chi15.pca1' , .SDcols = names(demography.dt)[2:13]]
demography.dt[,lapply(.SD, mean) , by = 'sp.g0.chi15.pca2' , .SDcols = names(demography.dt)[2:13]]
demography.dt[,lapply(.SD, mean) , by = 'sp.g0.chi15.pca3' , .SDcols = names(demography.dt)[2:13]]

row.names(pca1$x) = demography.df$town.name
PCbiplot(pca1)

#---------------------------- st --------------------------------------------------------#
ST.dt = merge(ST.dt ,town.zip[,.(zip,town.name,longitude,latitude)])
ST.dt = str.transform(ST.dt , c('longitude','latitude'),as.numeric )
ST.df = as.data.frame(ST.dt)
ST.df= na.omit(ST.df)

coordinates(ST.df) <- c('longitude','latitude')
# ST.df <- spTransform(ST.df,
#                              CRS("+proj=merc +datum=WGS84 +ellps=WGS84"))

# pca
pca2 <- prcomp(formula = ~ college  +log10(income)  +occp+ses+ ses5,  
              data = ST.df,                           
              scale = TRUE)   
# plot(pca2,         
#      type="line", 
#      main="Scree Plot for social stratification")
(vars2 <- (pca2$sdev)^2)  # 從pca中取出標準差(pca$sdev)後再平方，計算variance(特徵值)
(props2 <- vars2 / sum(vars2))    
(cumulative.props2 <- cumsum(props2))  # 累加前n個元素的值
pca2$rotation[,1]
ST.df$pca1 = pca2$x[,1]
saveRDS(ST.df,'data/rdsfile/ST.df.pca.rds')
# pca done

spodt.results2 <- spodt(pca1 ~ 1, data = ST.df, graft = 0.05,
                       level.max = 10, min.parent = 25, min.child = 15, rtwo.min = 0.01)
spodt.tree(spodt.results2)
SSL.result2 <- spodtSpatialLines(spodt.results2, ST.df)
plot(SSL.result2)
points(ST.df, cex = log(ST.df$college *20 ))

cbind(ST.df$town.name , spodt.results2@partition)
ST.dt[,sp.g.05.chi15.pca1:=spodt.results2@partition]
ST.dt[,lapply(.SD, mean) , by = 'sp.g.05.chi15.pca1' , .SDcols = names(ST.dt)[2:7]]

row.names(pca2$x) = ST.df$town.name
PCbiplot(pca2)

#------------------- life -----------------------------------------------------------------#

life2.dt = merge(life2.dt ,town.zip[,.(zip,town.name,longitude,latitude)])
life2.dt = str.transform(life2.dt , c('longitude','latitude'),as.numeric )
life2.df = as.data.frame(life2.dt)
life2.df= na.omit(life2.df)

coordinates(life2.df) <- c('longitude','latitude')

# pca
pca3 <- prcomp(formula = ~ unhealth+ unhappy+ unsatisfaction,  
               data = life2.df,                           
               scale = TRUE)   
# plot(pca2,         
#      type="line", 
#      main="Scree Plot for social stratification")
(vars3 <- (pca3$sdev)^2)  # 從pca中取出標準差(pca$sdev)後再平方，計算variance(特徵值)
(props3 <- vars3 / sum(vars3))    
(cumulative.props3 <- cumsum(props3))  # 累加前n個元素的值
pca3$rotation[,1:2]
life2.df$pca1 = pca3$x[,1]
life2.df$pca2 = pca3$x[,2]
saveRDS(life2.df,'data/rdsfile/life2.df.pca.rds')
# pca done
# proj4string(life2.df) <- "+proj=longlat +datum=WGS84 +ellps=WGS84"
life2.df <- spTransform(life2.df,
                     CRS("+proj=merc +datum=WGS84 +ellps=WGS84"))
#pca 1
spodt.results3.pca1 <- spodt( pca1 ~ 1, data = life2.df, graft = 0,
                              level.max = 100, min.parent = 25, min.child = 15, rtwo.min = 0.01)
spodt.tree(spodt.results3.pca1)
SSL.result3.pca1 <- spodtSpatialLines(spodt.results3.pca1, life2.df)

png(filename="spodt.results3.pca1.png", 
    units="in", 
    width=16, 
    height=26, 
    pointsize=12, 
    res=72)
plot(SSL.result3.pca1)
points(life2.df, cex = ((life2.df$pca1*3)))
dev.off()

# pca.2
spodt.results3.pca2 <- spodt( pca2 ~ 1, data = life2.df, graft = 0,
                              level.max = 10, min.parent = 25, min.child = 15, rtwo.min = 0.01)
spodt.tree(spodt.results3.pca2)
SSL.result3.pca2 <- spodtSpatialLines(spodt.results3.pca2, life2.df)
png(filename="spodt.results3.pca2.png", 
    units="in", 
    width=16, 
    height=26, 
    pointsize=12, 
    res=72)
plot(SSL.result3.pca2)
points(life2.df, cex = (life2.df$pca2+.05) *4 )
dev.off()



cbind(life2.df$town.name , spodt.results3.pca1@partition)
cbind(life2.df$town.name , spodt.results3.pca2@partition)

life2.dt[,sp.g.0.chi15.pca1:=spodt.results3.pca1@partition]
life2.dt[,sp.g.0.chi15.pca2:=spodt.results3.pca2@partition]

life2.dt[,lapply(.SD, mean) , by = 'sp.g.0.chi15.pca1' , .SDcols = names(life2.dt)[2:5]]
life2.dt[,lapply(.SD, mean) , by = 'sp.g.0.chi15.pca2' , .SDcols = names(life2.dt)[2:5]]
life2.dt[,lapply(.SD, mean) , by = 'kmeanclu.3' , .SDcols = names(life2.dt)[2:5]]

row.names(pca3$x) = life2.dt$town.name
PCbiplot(pca3)

#---------------------------------------------------------------------#
# 每一個類別各有那些行政區

life2.dt[,.SD , by = 'sp.g.0.chi15.pca1' , .SDcols = 'town.name']
life2.dt[,paste0(town.name , collapse = '、') ,by = 'sp.g.0.chi15.pca2' ]
x = lapply(unique(life2.dt$sp.g.0.chi15.pca2), function(x) {
  life2.dt[ sp.g.0.chi15.pca2 == x,paste0(town.name , collapse = ';')]
} )

names(x) = unique(life2.dt$sp.g.0.chi15.pca2)
lapply(list, function)
life2.dt[,sp.g.0.chi15.pca2.town.list:=unlist(x)]

#------------------------------- 分類結果評估 --------------------------------------#
#--------- Silhouette method -------------------------------#

# library(cluster)
# silhouette.res = function(data,cluster , distance.method = 'euclidean'){
#   SIL = silhouette(cluster, dist(data,method = distance.method))
#   aggregate(SIL[,3], list(SIL[,1]), mean)  
# }
# 
# silhouette.res(demography.dt[,2:12] , demography.dt$south ,'maximum')
# silhouette.res(demography.dt[,2:12] , demography.dt$kmeanclu.4)
# silhouette.res(demography.dt[,2:12] , spodt.results1.pca1@partition , 'maximum')
# 
# silhouette.res(ST.dt[,2:6] , ST.dt$south)
# silhouette.res(ST.dt[,2:6] , ST.dt$kmeanclu.3)
# silhouette.res(ST.dt[,2:6], spodt.results2@partition)
# 
# silhouette.res(life2.dt[,2:4] , life2.dt$south)
# silhouette.res(life2.dt[,2:4] , life2.dt$kmeanclu.3)
# silhouette.res(life2.dt[,2:4], spodt.results3.pca2@partition)

