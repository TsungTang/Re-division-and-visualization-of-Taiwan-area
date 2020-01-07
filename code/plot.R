
library(plotly)
library(pipeR)
library(data.table)
#--------- spatial partitioning method
# demography plot 

demography.df.pca <- readRDS("data/rdsfile/demography.df.pca.rds")

dem.p <- demography.df.pca@data[,2:18] %>>% 
  plot_ly(x = ~pca1) %>>%
  add_trace(y = ~pca2 , 
            text = ~paste("Town.name: ", town.name , '<br>Group:', kmeanclu.4 ,'<br>Primary industry: ', round(occI,3), 
                          '<br>Hakka: ', round(hakka,3) , '<br>Aboriginal:', round(aboriginal,3) ,'<br>Mainland:', round(mainland,3) ,
                          '<br>Elder:', round(elder,3) ,'<br>Buddhism:', round(buddhism,3) ,'<br>Christianity:', round(christianity,3) ,
                          '<br>Folk:', round(folk,3) ,'<br>Taoism:', round(taoism,3) ,'<br>No.religion:', round(non,3) ,
                          '<br>Female:', round(female,3)) ,
            color = ~factor(kmeanclu.4)) 

# htmlwidgets::saveWidget(dem.p, "demo.cluster.html")

# demography.df.pca@data[,2:18] %>>%
#   ggplot(aes(pca1,  pca2, color = factor(kmeanclu.4))) +
#   geom_point()


# st plot 
ST.df.pca <- readRDS("data/rdsfile/ST.df.pca.rds")

st.p <- ST.df.pca %>>% 
  plot_ly(x = ~pca1) %>>%
  add_trace(y = ~pca2 , 
            text = ~paste("Town.name: ", town.name , '<br>Group:', kmeanclu.3 , '<br>College: ', round(college,3) , 
                          '<br>Income:', round(income,3) ,'<br>Occp:', round(occp,3) ,'<br>Ses:', round(ses,3) ,
                          '<br>Ses5:', round(ses5,3)) , color = ~factor(kmeanclu.3)) 

# htmlwidgets::saveWidget(st.p, "st.cluster.html")

# ST.df.pca@data %>>%
#   ggplot(aes(pca1,  pca2, color = factor(kmeanclu.3))) +
#   geom_point()

# life plot 
life2.df.pca <- readRDS("data/rdsfile/life2.df.pca.rds")

life.p <- life2.df.pca@data %>>% 
  plot_ly(x = ~pca1) %>>%
  add_trace(y = ~pca2 , text = ~paste("town.name: ", town.name, '<br>Group:', kmeanclu.3 , 
                                      '<br>Unhealth: ', round(unhealth,3) , 
                                      '<br>Unhappy:', round(unhappy,3) ,'<br>Unsatisfaction:', round(unsatisfaction,3)) ,
            color = ~factor(kmeanclu.3)) 

# htmlwidgets::saveWidget(life.p , "life.cluster.html")

# life2.df %>>%
#   ggplot(aes(pca1,  pca2, color = factor(kmeanclu.3))) +
#   geom_point()


#--------- pca1、pca2 plot
town.s <- readRDS("/Volumes/GoogleDrive/我的雲端硬碟/181109.classification.area/data/rdsfile/map/twon.s.rds")
town.s.dt <- town.s@data %>>% as.data.table()

# demo
demo.pca2 <- town.s.dt %>>% 
  plot_ly(x = ~demo.pca1) %>>%
  add_trace(y = ~demo.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', demo.pca2_8 ,'<br>Primary industry: ', round(occI,3), '<br>Hakka: ', round(hakka,3) , 
                          '<br>Aboriginal:', round(aboriginal,3) ,'<br>Mainland:', round(mainland,3) ,'<br>Elder:', round(elder,3) ,
                          '<br>Buddhism:', round(buddhism,3) ,'<br>Christianity:', round(christianity,3) ,'<br>Folk:', round(folk,3) ,
                          '<br>Taoism:', round(taoism,3) ,'<br>No.religion:', round(non,3) ,'<br>Female:', round(female,3)) ,
            color = ~factor(demo.pca2_8)) 

# htmlwidgets::saveWidget(demo.pca2 , "demo.pca2.html")

demo.pca1 <- town.s.dt %>>% 
  plot_ly(x = ~demo.pca1) %>>%
  add_trace(y = ~demo.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', demo.pca1_9 ,'<br>Primary industry: ', round(occI,3),'<br>Hakka: ', round(hakka,3) , 
                          '<br>Aboriginal:', round(aboriginal,3) ,'<br>Mainland:', round(mainland,3) ,'<br>Elder:', round(elder,3) ,
                          '<br>Buddhism:', round(buddhism,3) ,'<br>Christianity:', round(christianity,3) ,'<br>Folk:', round(folk,3) ,
                          '<br>Taoism:', round(taoism,3) ,'<br>No.religion:', round(non,3) ,'<br>Female:', round(female,3)) ,
            color = ~factor(demo.pca1_9)) 

# htmlwidgets::saveWidget(demo.pca1 , "demo.pca1.html")

# life
life.pca1 <- town.s.dt %>>% 
  plot_ly(x = ~life.pca1) %>>%
  add_trace(y = ~life.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', life.pca1_7 , '<br>Unhealth: ', round(unhealth,3) , 
                          '<br>Unhappy:', round(unhappy,3) ,'<br>Unsatisfaction:', round(unsatisfaction,3)) , color = ~factor(life.pca1_7)) 
# htmlwidgets::saveWidget(life.pca1 , "life.pca1.html")

life.pca2 <- town.s.dt %>>% 
  plot_ly(x = ~life.pca1) %>>%
  add_trace(y = ~life.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', life.pca2_6 , '<br>Unhealth: ', round(unhealth,3) , 
                          '<br>Unhappy:', round(unhappy,3) ,'<br>Unsatisfaction:', round(unsatisfaction,3)) , color = ~factor(life.pca2_6)) 

# htmlwidgets::saveWidget(life.pca2 , "life.pca2.html")


# st
town.s.dt[,ST.pca2:=ST.df.pca$pca2[match(town.s.dt$zip, ST.df.pca$zip)]]
town.s.dt[,ST.pca2_1:=ST.df.pca$kmeanclu.3[match(town.s.dt$zip, ST.df.pca$zip)]]


st.pca1 <- town.s.dt %>>% 
  plot_ly(x = ~ST.pca1) %>>%
  add_trace(y = ~ST.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', ST.pca1_8 , '<br>College: ', round(college,3) , 
                          '<br>Income:', round(income,3) ,'<br>Occp:', round(occp,3) ,'<br>Ses:', round(ses,3) ,
                          '<br>Ses5:', round(ses5,3)) , color = ~factor(ST.pca1_8)) 
# htmlwidgets::saveWidget(st.pca1 , "st.pca1.html")

st.pca2 <- town.s.dt %>>% 
  plot_ly(x = ~ST.pca1) %>>%
  add_trace(y = ~ST.pca2 , 
            text = ~paste("Town.name: ", paste0(COUNTYNAME,TOWNNAME) , '<br>Group:', ST.pca2_1 , '<br>College: ', round(college,3) , 
                          '<br>Income:', round(income,3) ,'<br>Occp:', round(occp,3) ,'<br>Ses:', round(ses,3) ,
                          '<br>Ses5:', round(ses5,3)) , color = ~factor(ST.pca2_1)) 

# htmlwidgets::saveWidget(st.pca2 , "st.pca2.html")

