# install package
list.of.packages <- c("ggplot2", "Rcpp" , 'data.table' , 'pipeR' ,
                      'haven' ,'igraph','useful','stringr','factoextra','maps' ,'cluster','mclust')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

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

tscs172.sav = read_sav('data/2017網絡組限制資料/tscs172_20180426.sav')
setDT(tscs172.sav)

table(tscs172.sav$a17 >=96)
tscs172.sav[a17 >=96 ,a17:= NA]

# alldta
# alldta = read_dta('data/180917b.dta')
# setDT(alldta) 
# alldta = alldta[!is.na(zip)]

#---- 行政區名及經緯度資料 -----#
town.zip = fread('data/外部資料/行政區經緯度.csv' ,encoding='UTF-8' )
setnames(town.zip , c('town.name' , 'zip' , 'longitude' , 'latitude' , 'TGOS_URL'))
ins.dt= as.data.table(as.list(c( '台南市西區' , 703 , rep(NA ,3) )) ) 
setnames(ins.dt , names(town.zip))
town.zip = rbind(town.zip ,ins.dt  )
town.zip[,zip:= as.numeric(zip)]

# ! duplicated zip
town.zip[zip==300,town.name:='新竹市']
town.zip[zip==600 ,town.name:='嘉義市']
town.zip = town.zip[!duplicated(zip)]

town.zip[,south:=ifelse((zip >= 600 & zip <= 885)|(zip >= 900 & zip <= 947 ) , 1 , ifelse(is.na(zip) , NA ,0))]


# merge
tscs172.sav = merge(tscs172.sav , town.zip[,c('town.name', 'zip','longitude','latitude' ,'south')] , by= 'zip' , all.x = T ) 
# alldta = merge(alldta , town.zip[,1:4] , by= 'zip' , all.x = T ) 


#---- 行政區人口資料 ----#
town.population = fread('data/外部資料/行政區人口密度.csv')
town.population = town.population[2:371]
setnames(town.population ,c('statistic_yyy' ,'site_id') , c('pop.suryear' , 'town.name'  ))
town.population = cbind(town.population[,1:2] , town.population[,lapply(.SD, as.numeric) , .SDcols = c('people_total','area', 'population_density')]
)

town.population[town.name %>>%str_detect('新竹市'), (names(town.population)[-1]) := as.list(c('新竹市' , sum(people_total),sum(area), sum(people_total)/sum(area) ) )]
town.population[town.name %>>%str_detect('嘉義市'), (names(town.population)[-1]) := as.list(c('嘉義市' , sum(people_total),sum(area), sum(people_total)/sum(area) ) )]
town.population = town.population[!duplicated(town.name)]

tscs172.sav = merge(tscs172.sav , town.population , by= 'town.name' , all.x = T )  
# alldta = merge(alldta , town.population , by= 'town.name' , all.x = T )  


#--- 傳統人口學分類 ---- #
# 服務業人口排分比
# 工業人口百分比
# 65歲以上人口百分比
# 專科以上教育人口百分比
# 男性人口百分比
# 人口密度 # 外部資料

tscs172.sav[,.N , by = 'zip']

# population density
tscs172.sav[, population_density := as.numeric(population_density)]

# 65+
tscs172.sav[,old:= ifelse(age>=65 , 1 , 0)]

# tscs172.sav[f6b5isco88>9990 , f6b5isco88:= NA]
# tscs172.sav[, service:=ifelse(f6b5isco88 >= 5000 & f6b5isco88 < 6000  ,1 , 0)]  #服務業

# 製造業(二級) 服務業(三級)
OCP.III = (tscs172.sav$f6a3 %>>% attr('labels'))[names(tscs172.sav$f6a3 %>>% attr('labels')) %>>%
                                         str_detect('服務業|餐飲業|旅行業|代理業|表演業|研究業|博弈|教育服務|圖書館|國際組織及外國機構|旅店業|社會安全|飲食業|顧問業|不動產|旅游業|倉儲業|租賃業|廣告業|回收業|批發業|零售業|運輸業|輔助業|倉儲業|快遞業|出版業|播送業|電信業|金融中介業|保險業|金融業')]
OCP.II = (tscs172.sav$f6a3 %>>% attr('labels'))[names(tscs172.sav$f6a3 %>>% attr('labels')) %>>% 
                                         str_detect('製造業|工業|礦業|採取業|紡織業|安裝業|整治業|供應業|處理業|工程業|營造業')]
tscs172.sav[f6a3>990 , f6a3:= NA]
tscs172.sav[, OCP.III:= ifelse(f6a3%in%OCP.III  ,1 ,0 )]
tscs172.sav[, OCP.II:= ifelse(f6a3%in%OCP.II  ,1 ,0 )]

# EDU
tscs172.sav[edugp4 < 90,  n.edu:= ifelse(edugp4==4  , 1 , 0)]

# 
tscs172.sav[, male := ifelse(a1==1 , 1 ,0 )]


## mean by zip
# sub1 = merge(town.zip[,1:2] , sub1 , by = 'zip' , all.y = T)

# # kmean
# kmean.best = FitKMeans(sub1[,3:8] , max.clusters = 8 , nstart = 25 ,seed =2001)
# PlotHartigan(kmean.best)
# kmeans.cluster <- kmeans(sub1[,3:8], centers=4 , nstart = 20) 
# 
# sub1[,kmeans.cluster:=kmeans.cluster$cluster]

# -------------------  Hierarchical Clustering ----------------------#
# Agglomerative Hierarchical Clustering
sub1 = tscs172.sav[,lapply(.SD , function(x) mean(x , na.rm = T)  ) , .SDcols = c('old','OCP.III','OCP.II','n.edu', 'male', 'population_density') , by = 'zip']
# mean by zip4
sub1 = merge(town.zip[,1:2] , sub1 , by = 'zip' , all.y = T)
# Dissimilarity matrix
d <- dist(sub1[,3:8], method = "euclidean" )

# Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )
# hc1$labels = sub1$town.name

# plot
# fviz_dend(hc1, rect = TRUE, cex = 0.7,
#           k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07")) +
#   theme(text = element_text(size = 7.5),
#         axis.title = element_text(size = 7.5),
#         axis.text = element_text(size = 7.5))
# Similarity measures
# Compute the dissimilarity matrix
# df = the standardized data
# res.dist <- dist(sub1[,3:8], method = "euclidean")
# #
# gap_stat <- clusGap(sub1[,3:7], FUN = hcut, nstart = 25, 
#                     K.max = 10, B = 100) 
# fviz_gap_stat(gap_stat)
res <- hcut(sub1[,3:8], k = 4, stand = TRUE )
res$labels = sub1$town.name
sub1$hc = res$cluster
fviz_dend(res, rect = TRUE, cex = .9,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07") ,horiz =T ) +
  theme(text = element_text(size = 22),
        axis.title = element_text(size = 22),
        axis.text = element_text(size = 22))

fviz_cluster(res,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"), 
             ellipse.type = "convex", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             show.clust.cent = FALSE, ggtheme = theme_minimal())
# Compute cophentic distance
res.coph <- cophenetic(res)
# Correlation between cophenetic distance and
# the original distance
cor(res.dist, res.coph)


sub1[,hcluster:=res$cluster]

fviz_nbclust(sub1[,2:6], hcut, method = "gap_stat")

res.km <- eclust(sub1[,2:6], "kmeans", nstart = 25)

res <- get_clust_tendency(sub1[,3:8], 40, graph = TRUE)

res$hopkins_stat

# Determining Optimal Clusters ---##

# fviz_nbclust(sub1[,3:8], FUN = hcut, method = "wss")
# fviz_nbclust(sub1[,3:8], FUN = hcut, method = "silhouette")
# gap_stat <- clusGap(sub1[,3:8], FUN = hcut, nstart = 25, K.max = 10, B = 50)
# fviz_gap_stat(gap_stat)

sub1[,south:=ifelse((zip >= 600 & zip <= 885)|(zip >= 900 & zip <= 947 ) , 1 , ifelse(is.na(zip) , NA ,0))]

# network communication
# Dissimilarity matrix
# d <- dist(sub1[,3:8], method = "euclidean" )
# 
# num.d = ( d %>>% as.numeric() )
# d.zscore = (num.d - mean(num.d) )/sd(num.d)
# d.zscore = d.zscore %>>% round(0)
# d.zscore = ifelse(d.zscore<1 , 0 ,1)
# for (i in 1:length(d)) {
#   d[i] = d.zscore[i]   
# }
# d = as.matrix(d)
# colnames(d) = sub1$town.name ;row.names(d) = sub1$town.name
# g = graph_from_adjacency_matrix(d , weighted = T ,mode ='undirected')
# 
# wc = walktrap.community(g , weights = T)
# temp = as.data.table(cbind(wc$names , wc$membership))
#--------------------- not well--------------------------

# model base method
sub1.sd <- scale(sub1[,3:8]) # Standardize the data
mc <- Mclust(sub1.sd , G = 4)            # Model-based-clustering
summary(mc)                 # Print a summary
# BIC values used for choosing the number of clusters
fviz_mclust(mc, "classification", geom = "point", 
            pointsize = 1.5, palette = "jco")
# mc$classification
sub1$mc  = mc$classification

#-------------------------------------------------------------------------------------#

#------------------ B2a - B2d  ------------------------------------------------#
sub2 = tscs172.sav[,.(zip , b2a ,b2b,b2c,b2d )]
# -------------------  Hierarchical Clustering ----------------------#
# Agglomerative Hierarchical Clustering

# Dissimilarity matrix
d <- dist(sub2[,2:5], method = "euclidean" )

# Hierarchical clustering using Complete Linkage
res <- hcut(sub2[,2:5],k = 3, stand = TRUE  )
res$labels = sub1$town.name
sub2$hc = res$cluster

fviz_dend(res, rect = TRUE, cex = .9,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800") ,horiz =T ) +
  theme(text = element_text(size = 22),
        axis.title = element_text(size = 22),
        axis.text = element_text(size = 22))

