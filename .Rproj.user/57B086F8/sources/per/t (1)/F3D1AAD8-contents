list.of.packages <- c("klaR",'cba')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(klaR)
library(cba)

# 人口學
sub1.all = tscs172.sav[,.(old,OCP.III,OCP.II,edugp4,male)]
sub1.all[,edugp4 := ifelse(edugp4 == 99 , NA ,edugp4)]
sub1.all =  sub1.all[,lapply(.SD, as.factor) , .SDcols = c('old','OCP.III', 'OCP.II', 'edugp4', 'male')]  
sub1.all = na.omit(sub1.all)

sub1.all.torun.ohe <- model.matrix(~.-1, data=sub1.all)
sub1.all.torun.ohe.binary <- as.dummy(sub1.all.torun.ohe)
result.rock <-rockCluster(mushroom.torun.binary, 2, theta=0.8)


result.kmean = kmeans(sub1.all.torun.ohe, 4, nstart = 50, iter.max = 15) 


result.kmode <- kmodes(sub1.all.torun.ohe[,-1] , 8, iter.max = 50, weighted = FALSE)
result.kmode <- kmodes(sub1.all.torun.ohe[,-1] , 8, iter.max = 50, weighted = FALSE)

result.rock = rockCluster[as.matrix(sub1.all.torun.ohe[,-1]), 8, theta=0.8]

dt.transform = function(dt , var , ... ){
  changedt = dt[,lapply(.SD, ... ) , .SDcols = var]
  
  nochange.var = names(dt)[!(names(dt) %in% var)]
  if(length(nochange.var)>=1 ){
    unchange.dt = dt[,c(nochange.var) , with =F]
  out.dt  = cbind(unchange.dt , changedt)
  }else{
    out.dt = changedt
  }
  
  return(out.dt)
}
 

sub1.all = tscs172.sav[,.(id, zip , town.name , south ,  old,OCP.III,OCP.II,edugp4,male)]
sub1.all[,edugp4 := ifelse(edugp4 == 99 , NA ,edugp4)]
sub1.all = na.omit(sub1.all)

sub1.all2 = dt.transform(sub1.all , c('old','OCP.III', 'OCP.II', 'edugp4', 'male') , as.factor)
sub1.all2  =  sub1.all2[,5:9]

#' Compute Gower distance
#' 
sub1.all2 = model.matrix(~.-1, data=sub1.all2)[,-1]
# index <- 1:4
# sub1.all2[, lapply(.SD, function(x) index == x)]
# inds <- unique(sub1.all2$edugp4)
# sub1.all2[, (paste0('edugp',inds)) := lapply(inds, function(x) edugp4 == x)]



gower_dist <- daisy(sub1.all2, metric = "gower")
gower_mat <- as.matrix(gower_dist)
#' Print most similar clients
sub1.all2[which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]), arr.ind = TRUE)[1, ], ]
#' Print most dissimilar clients
sub1.all2[which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]), arr.ind = TRUE)[1, ], ]

sil_width <- c(NA)
for(i in 3:13){  
  pam_fit <- pam(gower_dist, diss = TRUE, k = i)  
  sil_width[i] <- pam_fit$silinfo$avg.width  
}
plot(1:13, sil_width,
     xlab = "Number of clusters",
     ylab = "Silhouette Width")
lines(1:13, sil_width)

kmedoid.cluster <- pam(sub1.all2, k=7) 

# 檢視不同類別的特性 
library(dplyr)
pam_results <-as.data.frame(apply(sub1.all2, 2, as.numeric)) %>%
  mutate(cluster = kmedoid.cluster$clustering) %>%
  group_by(cluster) %>%
  do(the_summary = summary(.))
pam_results$the_summary
#-----#

# 南部與非南部人的組成是否有差異 -----    #
# chi sqat test
sub1.all[,kmedoid.cluster:=kmedoid.cluster$clustering]
with(sub1.all , table(kmedoid.cluster ,south)) %>>% prop.table(2)
with(sub1.all , chisq.test(kmedoid.cluster ,south))  # not signifcant

#--------------------------------------#

# clusting by zip
sub1.zip =as.data.frame.matrix(with(sub1.all , table( zip , kmedoid.cluster)) %>>% prop.table(2))
match.town.name = sub1.all[match(row.names(sub1.zip) , as.character(sub1.all$zip)),]$town.name

res <- hcut(sub1.zip, k = 4, stand = TRUE )
res$labels = match.town.name
# sub1$hc = res$cluster
fviz_dend(res, rect = TRUE, cex = .9,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07") ,horiz =T ) +
  theme(text = element_text(size = 15),
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 15))




