
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
library(nnet)

# alldta
alldta = read_dta('data/180917b.dta')
setDT(alldta)
alldta = alldta[!is.na(zip)]

label = read_sav('data/180917label+data.sav')

alldta[zip==703 ,zip:=700]

#---- 行政區名及經緯度資料 -----#
town.zip = fread('data/外部資料/行政區經緯度.csv' ,encoding='UTF-8' )
setnames(town.zip , c('town.name' , 'zip' , 'longitude' , 'latitude' , 'TGOS_URL'))
# ins.dt= as.data.table(as.list(c( '台南市西區' , 703 , rep(NA ,3) )) ) 
# setnames(ins.dt , names(town.zip))
# town.zip = rbind(town.zip ,ins.dt  )
town.zip[,zip:= as.numeric(zip)]

# ! duplicated zip
town.zip[zip==300,town.name:='新竹市']
town.zip[zip==600 ,town.name:='嘉義市']
town.zip = town.zip[!duplicated(zip)]

town.zip[,south:=ifelse((zip >= 600 & zip <= 885)|(zip >= 900 & zip <= 947 ) , 1 , ifelse(is.na(zip) , NA ,0))]

# south zip
south.zip = alldta[!duplicated(zip) & south ==1 ,zip ]

# merge
alldta = merge(alldta ,  town.zip[,c('town.name', 'zip','longitude','latitude' ,'south')] , by= 'zip' , all.x = T )


# Demography
# occI
# age
# ori.f
# reli
# sex
occI.dt = alldta[ , list('occI' = mean(occI , na.rm = T))  , by = 'zip' ]

alldta[age>99 | age < 19, age:=NA]
alldta[,ori_f:=ifelse(ori_f>=5 , NA , ori_f)]
alldta  = cbind(alldta ,class.ind(alldta$ori_f)[,-1] )
setnames(alldta , c('2','3','4') , c('hakka' , 'aboriginal' , 'mainland'))
ori.f.dt = alldta[ , lapply(.SD, mean ,na.rm = T), by = 'zip'  ,.SDcols = c('hakka' , 'aboriginal' , 'mainland')]
old.dt = alldta[ ,list('elder' = mean(ifelse(age>=65 , 1 ,0) , na.rm = T) ), by = 'zip' ]

alldta[reli%in% c(4,5,9,10,11,12,13,96,97,98,99),reli:= NA]
recode.reli = Vectorize(function(a) {
  switch(as.character(a),
         "1" = 'buddhism',
         '2' = 'taoism',
         "3" = 'folk-belief',
         '6' = 'christianity' ,
         '7' = 'christianity' ,
         '8' = 'non-rel' ,
         NA)
}, "a")
alldta[,reli2 := alldta$reli %>>% recode.reli ]
alldta  = cbind(alldta ,class.ind(alldta$reli2))
reli.dt = alldta[ , lapply(.SD, mean ,na.rm = T), by = 'zip'  ,
                  .SDcols = c( 'buddhism', 'christianity', 'folk-belief', 'non-rel', 'taoism')]
female.dt = alldta[, list( 'female'  = mean( ifelse(sex==2 , 1 ,0 ), na.rm = T) ) , by = 'zip' ]

demography.dt = Reduce(function(x, y) merge(x, y, all=TRUE), list(occI.dt, ori.f.dt, old.dt,reli.dt,female.dt))
demography.dt[,south:= ifelse(zip %in% south.zip , 1, 0) ]

# social stratification
# edu_y
# income
# occp
# ses
# ses5
college.dt = alldta[,list( 'college'  = mean( ifelse(edu_y>=16 , 1 ,0 ), na.rm = T) ) , by = 'zip' ]
alldta[,inco2:=NA]
recode.income = Vectorize(function(a) {
  switch(as.character(a),
         "1" = '0',
         '2' = '5000',
         "3" = '15000',
         '4' = '25000' ,
         '5' = '35000' ,
         '6' = '45000' ,
         '7' = '55000' ,
         '8' = '65000' ,
         '9' = '75000' ,
         '10' = '85000' ,
         '11' = '95000' ,
         '12' = '105000' ,
         '13' = '115000' ,
         '14' = '125000' ,
         '15' = '135000' ,
         '16' = '145000' ,
         '17' = '155000' ,
         '18' = '165000' ,
         '19' = '175000' ,
         '20' = '185000' ,
         '21' = '195000' ,
         '22' = '250000' ,
         '23' = '300000' ,
         NA)
}, "a")
alldta[,inco2 := inco %>>% recode.income ]
income.dt = alldta[,list( 'income'  = mean( as.numeric(inco2), na.rm = T) ) , by = 'zip' ]
occp.ses.dt = alldta[,list( 'occp'  = mean( as.numeric(occp), na.rm = T) ,
                        'ses'  = mean( as.numeric(ses), na.rm = T) ,
                        'ses5'  = mean( as.numeric(ses5), na.rm = T) ) , by = 'zip' ]
ST.dt = Reduce(function(x, y) merge(x, y, all=TRUE), list(college.dt, income.dt,occp.ses.dt))
ST.dt[,south:= ifelse(zip %in% south.zip , 1, 0) ]

# life status
# health 
## tscs161 g2a 5 R
## tscs152 q5  5 R
## tscs151 v71f 5 R; v71b 4 R
## tscs142 v77 5  * R
## tscs131 v95 5 R
## tscs122 e30 5 R
## tscs121	v103 5 
## tscs112 d19a	d19b  4 5 R
## tscs111	a5  5 R
## tscs102 v83c	v83d 4 5 R ;  v87c	v87d 4 5 * R
## tscs101 v69b	v70b 5 4 R ; v69f	v70f 5 4 * R
## tscs092 v94 4 * R
## tscs091 e3 4 * R
## tscs072 c17 5 R
## tscs071 g12 4 R 
## tscs051 v75 4 * R
## tscs042 v87 4 * R
## tscs021	v129 4 * R
## tscs002  v53 4 * R
alldta[,hea121_103:= 6-hea061_5]

x=alldta[,lapply(.SD, function(x) {
  x = ifelse(x>9,NA ,x)
  R.x= (max(x ,na.rm = T)+1)-x
  R.x=psycho::standardize(R.x) 
  return(R.x)
} ) , .SDcols = c('hea161_2a','hea152_5','hea151_71b' ,'hea151_71f' ,'hea142_77','hea131_95','hea122_30','hea121_103','hea112_19a','hea112_19b',
                  'hea111_a5','hea102_83c','hea102_83d','hea102_87d','hea102_87c','hea101_69b','hea101_70b','hea101_69f','hea101_70f',
                  'hea092_94' ,'hea091_3','hea072_17','hea071_12','hea051_75','hea042_87','hea021_129','hea002_53')]
x$hea112_19a %>>% table
X = apply(x, 1, function(x){
    mean(x , na.rm= T)
})

alldta[,health := ifelse(is.nan(X)|is.na(X) , NA , X) ]
health.dt = alldta[,mean(health,na.rm = T) ,by = 'zip']

# recode 2 catgorical 1= unhealth
x2=alldta[,lapply(.SD, function(x) {
  x = ifelse(x>9,NA ,x)
  if(max(x , na.rm = T) >4){
    x  = ifelse(x<=3 ,0 ,1)
  }else{
    x  = ifelse(x<=2 ,0 ,1)
  }
  return(x)
} ) , .SDcols = c('hea161_2a','hea152_5','hea151_71b','hea151_71f' ,'hea142_77','hea131_95','hea122_30','hea121_103','hea112_19a','hea112_19b',
                  'hea111_a5','hea102_83c','hea102_83d','hea102_87d','hea102_87c','hea101_69b','hea101_70b','hea101_69f','hea101_70f',
                  'hea092_94' ,'hea091_3','hea072_17','hea071_12','hea051_75','hea042_87','hea021_129','hea002_53')]
X2 = apply(x2, 1, function(x){
  mean(as.numeric(x) , na.rm= T)
})

alldta[,unhealth.2 := ifelse(is.nan(X2)|is.na(X2) , NA , X2) ]
unhealth.dt = alldta[,mean(unhealth.2,na.rm = T) ,by = 'zip']

# happy
## tscs161 g1 4  R
## tscs152 q6 5 R
## tscs151 v71e 4 R
## tscs142 v79 4  R
## tscs141 g14 4 R
## tscs131 v93 5 R
## tscs122 e28 4 R
## tscs121 v104 5 R
## tscs112 g7a 5 R ; g7b 7 R
## tscs111 g6 4 R
## tscs102 v86c	v86d 4 5 R
## tscs101 v69e	v70e 5 4 R
## tscs092 v96 4 R
## tscs091 d5 4 R
## tscs082	u16 5 R
## tscs072	c16 5 R
## tscs052	v31 4 R
## tscs051	v69 4 R
## tscs042  v88 4 R
## tscs022	g52 7 R
## tscs012	a11 4 R
## tscs002  v65 3 R
## tscs001	v99 3 R
# hap=alldta[,lapply(.SD, function(x) {
#   x =as.numeric(x)
#   x = ifelse(x>9,NA ,x)
#   R.x= (max(x ,na.rm = T)+1)-x
#   R.x=psycho::standardize(R.x)
#   return(R.x)
# } ) , .SDcols = c("hea001_99",'hea002_65','hea012_11' ,'hea022_52','hea042_88','hea051_69','hea052_31','hea072_16','hea082_16',
#                   'hea091_5','hea092_96','hea101_69e','hea101_70e','hea102_86c','hea102_86d','hea111_g6','hea112_7a','hea112_7b',
#                   'hea121_104' ,'hea122_28','hea131_93','hea141_14','hea142_79','hea151_71e','hea152_6','hea161_1')]
# hap = apply(hap, 1, function(x){
#   mean(x , na.rm= T)
# })
# alldta[,happy := ifelse(is.nan(hap)|is.na(hap) , NA , hap) ]
# happy.dt = alldta[,mean(happy,na.rm = T) ,by = 'zip']

# recode 2
unhap=alldta[,lapply(.SD, function(x) {
  x =as.numeric(x)
  x = ifelse(x>9,NA ,x)
  if(max(x , na.rm = T) ==5){
    x  = ifelse(x<=3 ,0 ,1)
  }else if(max(x , na.rm = T) > 5){
    x  = ifelse(x<=4 ,0 ,1)
  }else{
    x  = ifelse(x<=2 ,0 ,1)
  }
  return(x)
} ) , .SDcols = c("hea001_99",'hea002_65','hea012_11' ,'hea022_52','hea042_88','hea051_69','hea052_31','hea072_16','hea082_16',
                  'hea091_5','hea092_96','hea101_69e','hea101_70e','hea102_86c','hea102_86d','hea111_g6','hea112_7a','hea112_7b',
                  'hea121_104' ,'hea122_28','hea131_93','hea141_14','hea142_79','hea151_71e','hea152_6','hea161_1')]
unhap = apply(unhap, 1, function(x){
    mean(x , na.rm= T)  
})
alldta[,unhappy.2 := ifelse(is.nan(unhap)|is.na(unhap) , NA , unhap) ]
unhappy.dt = alldta[,mean(unhappy.2,na.rm = T) ,by = 'zip']


# life satisfication
## tscs161 g7 5 R
## tscs151 v71a 4 R
## tscs131 v94 5 R
## tscs112 g6 4 R
## tscs111 g5 5 R
## tscs102	v82c	v82d 4 5 R
## tscs101	v69a	v70a 5 4 R
## tscs071	g1 6 R
## tscs061	f5 5
## tscs051  v70 4 R
## tscs021  v138 6 R
alldta[,hea061_5:= 6-hea061_5]
# lif.sta=alldta[,lapply(.SD, function(x) {
#   x = ifelse(x>9,NA ,x)
#   R.x= (max(x ,na.rm = T)+1)-x
#   R.x=psycho::standardize(R.x) 
#   return(R.x)
# } ) , .SDcols = c("hea161_7",'hea151_71a','hea131_94' ,'hea111_g6','hea111_g5','hea102_82c',
#                   'hea102_82d','hea101_69a','hea101_70a',
#                   'hea071_1','hea061_5','hea051_70','hea021_138')]
# lif.sta = apply(lif.sta, 1, function(x){
#   mean(x , na.rm= T)
# })
# alldta[,life.sta := ifelse(is.nan(lif.sta)|is.na(lif.sta) , NA , lif.sta) ]
# life.sta.dt = alldta[,mean(life.sta,na.rm = T) ,by = 'zip']
# 
# life.dt = Reduce(function(x, y) merge(x, y, all=TRUE), list(health.dt, happy.dt,life.sta.dt))
# life.dt[,south:= ifelse(zip %in% south.zip , 1, 0) ]
# setnames(life.dt , c('V1.x','V1.y' , 'V1') , c('health','happy','satisfaction'))

#recode 2
lif.unsta=alldta[,lapply(.SD, function(x) {
  x = ifelse(x>9,NA ,x)
  if(max(x , na.rm = T) >=5){
    x  = ifelse(x<=3 ,0 ,1)
  }else{
    x  = ifelse(x<=2 ,0 ,1)
  }
  return(x)
} ) , .SDcols = c("hea161_7",'hea151_71a','hea131_94' ,'hea111_g6','hea111_g5','hea102_82c',
                  'hea102_82d','hea101_69a','hea101_70a',
                  'hea071_1','hea061_5','hea051_70','hea021_138')]
lif.unsta = apply(lif.unsta, 1, function(x){
  mean(x , na.rm= T)
})
alldta[,lif.unsta.2 := ifelse(is.nan(lif.unsta)|is.na(lif.unsta) , NA , lif.unsta) ]
lif.unsta.dt = alldta[,mean(lif.unsta.2,na.rm = T) ,by = 'zip']

# life2.dt = Reduce(function(x, y) merge(x, y, all=TRUE , by ='zip'), list(unhealth.dt, unhappy.dt,lif.unsta.dt))
life2.dt[,south:= ifelse(zip %in% south.zip , 1, 0) ]
setnames(life2.dt , c('V1.x','V1.y' , 'V1') , c('unhealth','unhappy','unsatisfaction'))






# dir.create('data/rdsfile')





