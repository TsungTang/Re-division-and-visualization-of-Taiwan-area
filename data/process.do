//create id
egen idnum = group(id_raw)
tostring year, gen(year_)
tostring idnum, gen(id_)
gen id=year_+"_"+id_

//tscs001
use "C:\temp\tscs001.dta", clear
keep id year v1 age v7a zip v10 v3 v4 v8 v111 v112 v6 v6a v104b v106 v106a2 k106a_0 v102ar v102br v103ar v103br v104ar v104br v102a v102b v103a v103b v104a v104b v99
rename id id_raw
rename v1 sex
recode v7a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v7a edu_raw //edu_rawdata
rename v10 zip15
recode v3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v4 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v3 v4 //dele ori_rawdata
recode v8 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10 11 13=9)(else=.) ,gen(reli)
drop v8 //dele reli_rawdata
recode v111 (23/max=.),gen(inco)
recode v112 (23/max=.),gen(incofami)
drop v111 v112 //dele inco_rawdata incofami_rawdata
recode v6 (1=1)(else=0) ,gen(mar1) 
recode v6a (1 3=2)(2=3)(4=4)(else=0) ,gen(mar2)
gen mar=mar1+mar2
recode mar (0=.)
drop v6 v6a mar1 mar2 //dele except mar
recode v104ar (1=1)(96/max=.)(else=0),gen(occI)
rename v104b posi
recode v102ar (1=1)(96/max=.)(else=0),gen(occI_f)
rename v102b posi_f
rename v99 hea001_99
//final
keep id_raw zip year sex age edu_raw zip15 hea001_99 posi_f posi edu_y ori_f ori_m reli inco incofami mar occI occI_f



//tscs002
use "C:\temp\tscs002.dta", clear
keep id year v1 age v7a zip v80 v3 v4 v12 v77 v78 v6 v6a v5 v72 v72a2 k72a2_0 v68ar v68br v69ar v69br v70ar v70br v68a v68b v69a v69b v70a v70b v46a v46b v46c v46d v46e v46f v46g v46h v46i v46j v46k v46l v53 v54 v55 v65
rename id id_raw
rename v1 sex
recode v7a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v7a edu_raw //edu_rawdata
rename v80 zip15
recode v3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v4 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v3 v4 //dele ori_rawdata
recode v12 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10 11 13=9)(else=.) ,gen(reli)
drop v12 //dele reli_rawdata
recode v77 (23/max=.),gen(inco)
recode v78 (23/max=.),gen(incofami)
drop v77 v78 //dele inco_rawdata incofami_rawdata
recode v6 (1=1)(else=0) ,gen(mar1) 
recode v6a (1 3=2)(2=3)(4=4)(else=0) ,gen(mar2)
gen mar=mar1+mar2
recode mar (0=.)
drop v6 v6a mar1 mar2 //dele except mar
rename v5 zipbir
recode v70ar (1=1)(96/max=.)(else=0),gen(occI)
rename v70b posi
recode v68ar (1=1)(96/max=.)(else=0),gen(occI_f)
rename v68b posi_f
rename v46a hea002_46a
rename v46b hea002_46b
rename v46c hea002_46c
rename v46d hea002_46d
rename v46e hea002_46e
rename v46f hea002_46f
rename v46g hea002_46g
rename v46h hea002_46h
rename v46i hea002_46i
rename v46j hea002_46j
rename v46k hea002_46k
rename v46l hea002_46l
rename v53 hea002_53
rename v54 hea002_54
rename v55 hea002_55
rename v65 hea002_65
//final
keep id_raw zip year sex age zipbir edu_raw hea002_46a hea002_46b hea002_46c hea002_46d hea002_46e hea002_46f hea002_46f hea002_46g hea002_46h hea002_46i hea002_46j hea002_46k hea002_46l hea002_53 hea002_54 hea002_55 hea002_65 posi_f posi zip15 edu_y ori_f ori_m reli inco incofami mar occI occI_f



//tscs011
use "C:\temp\tscs011.dta", clear
keep id year a1 age b1 zip a6 a3 a4 a5 o3 o4 a9 c3e c1ar c1br c2ar c2br c3ar c3br c1a c1b c2a c2b c3a c3b k2a k2b k2c k2d k2e k2f k2g k2h k2i k2j
rename id id_raw
rename a1 sex
recode b1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename b1 edu_raw //edu_rawdata
rename a6 zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a4 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a3 a4 //dele ori_rawdata
recode a5 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10 11 13=9)(else=.) ,gen(reli)
drop a5 //dele reli_rawdata
rename o3 inco
rename o4 incofami
recode a9 (1=1)(2=2)(4 5=3)(6=4)(else=.),gen(mar)
drop a9 //dele mar_rawdata
recode c3ar (1=1)(95/max=.)(else=0),gen(occI)
rename c3b posi
recode c1ar (1=1)(95/max=.)(else=0),gen(occI_f)
rename c1b posi_f
rename k2a hea011_2a
rename k2b hea011_2b
rename k2c hea011_2c
rename k2d hea011_2d
rename k2e hea011_2e
rename k2f hea011_2f
rename k2g hea011_2g
rename k2h hea011_2h
rename k2i hea011_2i
rename k2j hea011_2j
//final
keep id_raw zip year sex age zip15 edu_raw posi_f posi hea011_2a hea011_2b hea011_2c hea011_2d hea011_2e hea011_2f hea011_2g hea011_2h hea011_2i hea011_2j inco incofami edu_y ori_f ori_m reli mar occI occI_f


//tscs012
use "C:\temp\tscs012.dta", clear
keep id year a1 age a8a zip a4 a3 a9 a16 a18b a6 a6a a13_1 a13_2 a13_3 a13_4 a13_5 a13_6 a13_7 a13_8 a12ar a12br a12a a12b a11
rename id id_raw
rename a1 sex
recode a8a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a8a edu_raw //edu_rawdata
rename a4 zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
drop a3 //dele ori_rawdata
rename a9 reli
recode a16 (23/max=.),gen(inco)
drop a16 //dele inco_rawdata
recode a18b (22 23=22)(24 25=23)(26 27=24)(28 29 30 31 32=25)(33=26),gen(incofami)
drop a18b //dele incofami_rawdata
recode a6 (1=1)(else=0) ,gen(mar1) 
recode a6a (1 3=2)(2=3)(4=4)(else=0) ,gen(mar2)
gen mar=mar1+mar2
recode mar (0=.)
drop a6 a6a mar1 mar2 //dele except mar
recode a12ar (1=1)(95/max=.)(else=0),gen(occI)
rename a12b posi
rename a11 hea012_11
//final
keep id_raw zip year sex age zip15 edu_raw reli hea012_11 posi edu_y ori_f inco incofami mar occI


//tscs013
use "C:\temp\tscs013.dta", clear
keep id year v1 age v5a zip v3 v8 v6 v4 v7r v7 v15ar v15br v15a v15b
rename id id_raw
rename v1 sex
recode v5a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v5a edu_raw //edu_rawdata
recode v3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v3 v8 //dele ori_rawdata
recode v6 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10 11 13=9)(else=.) ,gen(reli)
drop v6 //dele reli_rawdata
rename v4 mar
rename v7 zipbir
//final
keep id_raw zip year sex age mar edu_raw zipbir edu_y ori_f ori_m reli

//tscs021
use "C:\temp\tscs021.dta", clear
keep id year v1 age v13a zip v4 v4r v5 v6 v12a v145 v146b v7 v3r v3 v48 v48a1 v48e v49b2 v56 v48 v48a1 kv48a_0 v56 v27 v27a kv27a_0 v27c2 v26ar v26b2r v49ar v49b2r v26a v26b2 v49a v49b2 v129 v132 v133 v138 v140a v140b v140c v140d v140e v140f v140g v140h
rename id id_raw
rename v1 sex
recode v13a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v13a edu_raw //edu_rawdata
rename v4 zip15
recode v5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v5 v6 //dele ori_rawdata
recode v12a (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10=9)(else=.) ,gen(reli)
drop v12a //dele reli_rawdata
rename v145 inco
recode v146b (22 23=22)(24 25=23)(26 27=24)(28 29 30 31 32=25)(33=26),gen(incofami)
drop v146b //dele incofami_rawdata
recode v7 (1=1)(2=2)(4=3)(5=4)(else=.),gen(mar)
drop v7 //dele mar_rawdata
rename v3 zipbir
//gen class
recode kv48a_0 (996/max=.)
gen class1 = v48==1 & kv48a_0>7
gen class2 = v48==1 & kv48a_0<8
gen class3 = v48==1 & v48a1==1
recode v49b2 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v56==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v56==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v56==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v56==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
//gen class_f
recode kv27a_0 (996/max=.)
gen class1f = v27==1 & kv27a_0>7
gen class2f = v27==1 & kv27a_0<8
gen class3f = v27==1 & v27a==1
recode v26b2 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(classf_)
gen class4f = v27c2==1 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class5f = v27c2==1 & classf_ ==2 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class6f = v27c2==2 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class7f = v27c2==2 & classf_ ==3 & class1f!=1 & class2f!= 1 & class3f!= 1 

recode v49ar (1=1)(96/max=.)(else=0),gen(occI)
rename v49b2 posi
recode v26ar (1=1)(96/max=.)(else=0),gen(occI_f)
rename v26b2 posi_f
rename v129 hea021_129
rename v132 hea021_132
rename v133 hea021_133
rename v138 hea021_138
rename v140a hea021_140a
rename v140b hea021_140b
rename v140c hea021_140c
rename v140d hea021_140d
rename v140e hea021_140e
rename v140f hea021_140f
rename v140g hea021_140g
rename v140h hea021_140h
//final
keep id_raw zip year sex age zipbir zip15 edu_raw posi_f posi hea021_129 hea021_132 hea021_133 hea021_138 hea021_140a hea021_140b hea021_140c hea021_140d hea021_140e hea021_140f hea021_140g hea021_140h inco edu_y ori_f ori_m reli incofami mar class1 class2 class3 class4 class5 class6 class7 class1f class2f class3f class4f class5f class6f class7f occI occI_f

//tscs022
use "C:\temp\tscs022.dta", clear
keep id year a1 age b1 zip a6r a6 a3 a4 a5 j1 j3 a9 c3b c3d c1ar c1br c3ar c3br c1a c1b c3a c3b g52 g53 g54 i9
rename id id_raw
rename a1 sex
recode b1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename b1 edu_raw //edu_rawdata
rename a6 zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a4 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a3 a4 //dele ori_rawdata
recode a5 (2=1)(3=2)(4=3)(5=4)(7=5)(8=6)(9=7)(1=8)(6 10 11 12 13=9)(else=.) ,gen(reli)
drop a5 //dele reli_rawdata
rename j1 inco
rename j3 incofami
recode a9 (1=1)(3=2)(4 5=3)(6=4)(else=.),gen(mar)
drop a9 //dele mar_rawdata
recode c3ar (1=1)(96/max=.)(else=0),gen(occI)
rename c3b posi
recode c1ar (1=1)(96/max=.)(else=0),gen(occI_f)
rename c1b posi_f
rename g52 hea022_52
rename g53 hea022_53
rename g54 hea022_54
rename i9 hea022_9
//final
keep id_raw zip year sex age zip15 edu_raw posi_f posi hea022_52 hea022_53 hea022_54 hea022_9 inco incofami edu_y ori_f ori_m reli mar occI occI_f


//tscs031
use "C:\temp\tscs031.dta", clear
keep id year a1 age a9 zip a4r a4 a5 a6 b94 b95 a7 a3r a3 a15 a15a2 ka15a2_0 a16ar a16br a16a a16b
rename id id_raw
rename a1 sex
recode a9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a9 edu_raw //edu_rawdata
rename a4 zip15
recode a5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a5 a6 //dele ori_rawdata
rename b94 inco
rename b95 incofami
recode a7 (1=1)(2=2)(4=3)(5=4)(else=.),gen(mar)
drop a7 //dele mar_rawdata
rename a3 zipbir
recode a16ar (1=1)(90/max=.)(else=0),gen(occI)
rename a16b posi
//final
keep id_raw zip year sex age zipbir zip15 edu_raw posi inco incofami edu_y ori_f ori_m mar occI


//tscs032
use "C:\temp\tscs032.dta", clear
keep id year v1 age v76 v12a zip v4a v4e v10a v79 v80 v6a v76e v76f v76d v76ar v76br v76a v76b
rename id id_raw
rename v1 sex
rename v76 occ88
recode v12a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v12a edu_raw //edu_rawdata
recode v4a (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v4e (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v4a v4e //dele ori_rawdata
recode v10a (790=1)(902=2)(901=3)(903=4)(690=5)(100=6)(200=7)(0=8)(904 960=9),gen(reli)
drop v10a //dele reli_rawdata
rename v79 inco
rename v80 incofami
recode v6a (5=1)(1=2)(3 4=3)(2=4)(else=.),gen(mar)
drop v6a //dele mar_rawdata
//gen class
recode v76f (995/max=.)
gen class1 = v76e==1 & v76f>7
gen class2 = v76e==1 & v76f<8
gen class3 = v76e==4
recode v76b (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v76d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v76d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v76d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v76d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v76ar (1=1)(95/max=.)(else=0),gen(occI)
rename v76b posi
//final
keep id_raw zip year sex age edu_raw occ88 posi inco incofami edu_y ori_f ori_m reli mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs041
use "C:\temp\tscs041.dta", clear
keep id year v1 age v122b2 v9a zip v4r v4 v5 v6 v108 v141 v142 v7 v3r v3 v122e v122f v122d v123c v123d v122ar v122b1r v122a v122b1 v123br v123b
rename id id_raw
rename v1 sex
rename v122b2 occ88
recode v9a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v9a edu_raw //edu_rawdata
rename v4 zip15
recode v5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v5 v6 //dele ori_rawdata
recode v108 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5 9 10 11 13=9)(else=.) ,gen(reli)
drop v108 //dele reli_rawdata
rename v141 inco
rename v142 incofami
recode v7 (5=1)(1=2)(3 4=3)(2=4)(else=.),gen(mar)
drop v7 //dele mar_rawdata
rename v3 zipbir
//gen class
recode v122f (999997/max=.)
gen class1 = v122e==1 & v122f>7
gen class2 = v122e==1 & v122f<8
gen class3 = v122e==4
recode v122b1 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v122d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v122d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v122d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v122d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v122ar (1=1)(97/max=.)(else=0),gen(occI)
rename v122b1 posi
rename v123b posi_f
//final
keep id_raw zip year sex age zipbir zip15 edu_raw posi occ88 posi_f inco incofami edu_y ori_f ori_m reli mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs042
use "C:\temp\tscs042.dta", clear
keep id year v1 age v11b2 v9a zip v7 v15b v90 v92 v6 v2r v4 v11b1 v12 v11ar v11b1r v11a v11b1 v84a v84b v84c v84d v84e v84f v84g v84h v84i v84j v85 v86 v87 v88
rename id id_raw
rename v1 sex
rename v11b2 occ88
recode v9a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v9a edu_raw //edu_rawdata
recode v7 (1=1)(2=2)(4=3)(3=4)(5 6=5)(else=.),gen(ori_f)
recode v15b (31 32 33 34 35 36 37=1)(40=2)(21 22 23 24=3)(72=4)(91=5)(50=6)(60=7)(10=8)(71 73 74 75 76 77 78 81 82 83 84 85 92 93 94 95 101 102 103 110=9)(else=.) ,gen(reli)
drop v15b //dele reli_rawdata
recode v90 (23/max=.),gen(inco)
recode v92 (23/max=.),gen(incofami)
drop v90 v92 //dele inco_rawdata incofami_rawdata
recode v6 (6=1)(1 2=2)(3 5=3)(4=4)(else=.),gen(mar)
drop v6 //dele mar_rawdata
rename v4 zipbir
recode v11ar (1=1)(97/max=.)(else=0),gen(occI)
rename v11b1 posi
rename v84a hea042_84a
rename v84b hea042_84b
rename v84c hea042_84c
rename v84d hea042_84d
rename v84e hea042_84e
rename v84f hea042_84f
rename v84g hea042_84g
rename v84h hea042_84h
rename v84i hea042_84i
rename v84j hea042_84j
rename v85 hea042_85
rename v86 hea042_86
rename v87 hea042_87
rename v88 hea042_88
//final
keep id_raw zip year sex age zipbir edu_raw posi occ88 hea042_84a hea042_84b hea042_84c hea042_84d hea042_84e hea042_84f hea042_84g hea042_84h hea042_84i hea042_84j hea042_85 hea042_86 hea042_87 hea042_88 edu_y ori_f reli inco incofami mar occI


//tscs051
use "C:\temp\tscs051.dta", clear
keep id year stratum2 v1 age v103b5 v102b5 v7 zip v112r2 v112 v4 v5 v11 v108 v110 v6 v6a v3r2 v104 v104a2 v104a2a v103b4 v102a3r v102b5r v103a3r v103b5r v102a3 v102b4 v102b5 v103a3 v103b5 v69 v70 v74a v74b v74c v74d v74e v74f v74g v74h v74i v74j v74k v74l v75 v76
rename id id_raw
rename stratum2 stra
rename v1 sex
rename v103b5 occ88
rename v102b5 occ88_f
recode v7 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v7 edu_raw //edu_rawdata
rename v112r2 stra15
rename v112 zip15
rename v4 ori_f
rename v5 ori_m
recode v11 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5=9)(9=9)(10=9)(11=9)(13=9)(97/max=.) ,gen(reli)
drop v11 //dele reli_rawdata
rename v108 inco
rename v110 incofami
recode v6 (1=1)(else=0) ,gen(mar1) 
recode v6a (1 3=2)(2=3)(4=4)(else=0) ,gen(mar2)
gen mar=mar1+mar2
recode mar (0=.)
drop v6 v6a mar1 mar2 //dele except mar
recode v103a3r (1=1)(96/max=.)(else=0),gen(occI)
rename v103b4 posi
recode v102a3r (1=1)(96/max=.)(else=0),gen(occI_f)
rename v102b4 posi_f
rename v69 hea051_69
rename v70 hea051_70
rename v74a hea051_74a
rename v74b hea051_74b
rename v74c hea051_74c
rename v74d hea051_74d
rename v74e hea051_74e
rename v74f hea051_74f
rename v74g hea051_74g
rename v74h hea051_74h
rename v74i hea051_74i
rename v74j hea051_74j
rename v74k hea051_74k
rename v74l hea051_74l
rename v75 hea051_75
rename v76 hea051_76
//final
keep id_raw zip stra year sex age ori_f ori_m edu_raw hea051_69 hea051_70 hea051_74a hea051_74b hea051_74c hea051_74d hea051_74e hea051_74f hea051_74g hea051_74h hea051_74i hea051_74j hea051_74k hea051_74l hea051_75 hea051_76 posi_f occ88_f posi occ88 inco incofami zip15 stra15 edu_y reli mar occI occI_f


//tscs052
use "C:\temp\tscs052.dta", clear
keep id year stratum2 v1 age v87b5 v72b5 v11 zip v4 v7 v8 v23 v135 v137 v16 v3 v87b4 v87d v87f v87g v72a3r v72b4r v87a3r v87b4r v72a3 v72b4 v87a3 v87b4 v31
rename id id_raw
rename stratum2 stra
rename v1 sex
rename v87b5 occ88
rename v72b5 occ88_f
recode v11 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v11 edu_raw //edu_rawdata
rename v4 zip15
recode v7 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_m)
drop v7 v8 //dele ori_rawdata
recode v23 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(12=8)(5=9)(9=9)(10=9)(else=.) ,gen(reli)
drop v23 //dele reli_rawdata
rename v135 inco
rename v137 incofami
recode v16 (5=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop v16 //dele mar_rawdata
rename v3 zipbir
//gen class
recode v87g (99997/max=.)
gen class1 = v87f==1 & v87g>7
gen class2 = v87f==1 & v87g<8
gen class3 = v87f==4
recode v87b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v87d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v87d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v87d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v87d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v87a3r (1=1)(97/max=.)(else=0),gen(occI)
rename v87b4 posi
recode v72a3r (1=1)(97/max=.)(else=0),gen(occI_f)
rename v72b4 posi_f
rename v31 hea052_31
//final
keep id_raw zip stra year sex age zipbir zip15 edu_raw hea052_31 posi_f occ88_f posi occ88 inco incofami edu_y ori_f ori_m reli mar class1 class2 class3 class4 class5 class6 class7 occI occI_f


//tscs061
use "C:\temp\tscs061.dta", clear
keep id year stratum2 a1 age k6b5 a9 zip k2 a3 a4 k1 k9 k11 a5 k3 k6d k6b4 k6e k6f k6a3r k6b4r k6a3 k6b4 f5
rename id id_raw
rename stratum2 stra
rename a1 sex
rename k6b5 occ88
recode a9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a9 edu_raw //edu_rawdata
rename k2 zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_f)
recode a4 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_m)
drop a3 a4 //dele ori_rawdata
rename k1 reli
recode k9 (24 25 26 =23)(90/max=.),gen(inco)
drop k9 //dele inco_rawdata
rename k11 incofami
recode a5 (6=1)(1=2)(3 5=3)(2=4)(else=.) ,gen(mar)
drop a5 //dele mar_rawdata
rename k3 zipbir
//gen class
recode k6f (0 99990/max=.)
gen class1 = k6e==1 & k6f>7
gen class2 = k6e==1 & k6f<8
gen class3 = k6e==4
recode k6b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = k6d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = k6d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = k6d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = k6d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode k6a3r (1=1)(95/max=.)(else=0),gen(occI)
rename k6b4 posi
rename f5 hea061_5
//final
keep id_raw zip stra year sex age edu_raw hea061_5 reli zip15 zipbir posi occ88 incofami edu_y ori_f ori_m inco mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs062
use "C:\temp\tscs062.dta", clear
keep id year stratum2 a1 age j8b5 a10a zip a5 a6 a8 j11 j12 a7 j8b4 j8d j8e j8f j8g j8a4r j8b5r j8a4
rename id id_raw
rename stratum2 stra
rename a1 sex
rename j8b5 occ88
recode a10a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a10a edu_raw //edu_rawdata
rename a5 ori_f
rename a6 ori_m
rename a8 reli
rename j11 inco
rename j12 incofami
recode a7 (6=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop a7 //dele mar_rawdata
//gen class
recode j8g (99995/max=.)
gen class1 = j8e==4 & j8g>7
gen class2 = j8e==4 & j8g<8
gen class3 = j8e==4 & j8f==2
recode j8b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = j8d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = j8d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = j8d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = j8d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode j8a4r (1=1)(95/max=.)(else=0),gen(occI)
rename j8b4 posi
//final
keep id_raw zip stra year sex age ori_f ori_m reli edu_raw posi occ88 inco incofami edu_y mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs071
use "C:\temp\tscs071.dta", clear
keep id year stratum2 a1 age d16b4 d2b4_r c1 zip a4 a5 a6 b1a h43 h45 a7 a3 d16b3 d20 d23 d24 d3 d4 d5 d15 d2a3r d2b3 d2b4r d16a3r d16b4r d2a3 d2b4 d16a3 g1 g12 g13 g14a g14b g14c g14d g14e g14f g14g g14h
rename id id_raw
rename stratum2 stra
rename a1 sex
rename d16b4 occ88
rename d2b4_r occ88_f
recode c1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename c1 edu_raw //edu_rawdata
rename a4 zip15
recode a5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a5 a6 //dele ori_rawdata
rename b1a reli
rename h43 inco
rename h45 incofami
recode a7 (1=1)(2=2)(4=3)(5=4)(else=.) ,gen(mar)
drop a7 //dele mar_rawdata
rename a3 zipbir
//gen class
recode d24 (9996/max=.)
gen class1 = d15==1 & d24>7
gen class2 = d15==1 & d24<8
gen class3 = d15==1 & d20==1
recode d16b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = d23==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = d23==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = d23==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = d23==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
//gen class_f
recode d4 (1=0)(2=1)(4/9=2)(else=.),gen(staff)
gen class1f = d15==1 & staff==2
gen class2f = d15==1 & staff==1
gen class3f = d15==1 & staff==0
recode d2b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(classf_)
gen class4f = d5==1 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class5f = d5==1 & classf_ ==2 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class6f = d5==2 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class7f = d5==2 & classf_ ==3 & class1f!=1 & class2f!= 1 & class3f!= 1 

recode d16a3r (1=1)(96/max=.)(else=0),gen(occI)
rename d16b3 posi
recode d2a3r (1=1)(96/max=.)(else=0),gen(occI_f)
rename d2b3 posi_f
rename g1 hea071_1
rename g12 hea071_12
rename g13 hea071_13
rename g14a hea071_14a
rename g14b hea071_14b
rename g14c hea071_14c
rename g14d hea071_14d
rename g14e hea071_14e
rename g14f hea071_14f
rename g14g hea071_14g
rename g14h hea071_14h
//final
keep id_raw zip stra year sex age zipbir zip15 reli edu_raw posi_f posi occ88 hea071_1 hea071_12 hea071_13 hea071_14a hea071_14b hea071_14c hea071_14d hea071_14e hea071_14f hea071_14g hea071_14h inco incofami occ88_f edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 class1f class2f class3f class4f class5f class6f class7f occI occI_f


//tscs072
use "C:\temp\tscs072.dta", clear
keep id year stratum2 a1 age a19b5 a11 zip a5 a8 a16 i3 i4 a14 a3r a3 a19d a19e a19f a19g a19b4 a19a3r a19b5r a19a3 c16 c17
rename id id_raw
rename stratum2 stra
rename a1 sex
rename a19b5 occ88
recode a11 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a11 edu_raw //edu_rawdata
recode a5 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_f)
recode a8 (1=1)(2=2)(4=3)(3=4)(5=5)(6=5)(else=.),gen(ori_m)
drop a5 a8 //dele ori_rawdata
rename a16 reli
rename i3 inco
rename i4 incofami
recode a14 (5=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop a14 //mar_rawdata
rename a3 zipbir
rename a3r strabir
//gen class
recode a19g (996/max=.)
gen class1 = a19e==3 & a19g>7
gen class2 = a19e==3 & a19g<8
gen class3 = a19e==3 & a19f==0
recode a19b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = a19d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = a19d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = a19d==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = a19d==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode a19a3r (1=1)(96/max=.)(else=0),gen(occI)
rename a19b4 posi
rename c16 hea072_16
rename c17 hea072_17
//final
keep id_raw zip stra year sex age zipbir edu_raw reli posi occ88 hea072_16 hea072_17 inco incofami strabir edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs081
use "C:\temp\tscs081.dta", clear
keep id year stratum2 a1 age e22b4 a8 zip a4 a5 a6 e23 e24 a7 a3 e22d e22e e22f e22g e22b2 e22a3r e22b4r e22a3 e4a e4b e4c e4d e4e e4f
rename id id_raw
rename stratum2 stra
rename a1 sex
rename e22b4 occ88
recode a8 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a8 edu_raw //edu_rawdata
rename a4 zip15
recode a5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a5 a6 //dele ori_rawdata
rename e23 inco
rename e24 incofami
recode a7 (1=1)(2=2)(4=3)(5=4)(else=.) ,gen(mar)
drop a7 //dele mar_rawdata
rename a3 zipbir
//gen class
recode e22g (9997/max=.)
gen class1 = e22e==4 & e22g>7
gen class2 = e22e==4 & e22g<8
gen class3 = e22e==4 & e22f==2
recode e22b2 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = e22d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = e22d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = e22d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = e22d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode e22a3r (1=1)(96/max=.)(else=0),gen(occI)
rename e22b2 posi
rename e4a hea081_4a
rename e4b hea081_4b
rename e4c hea081_4c
rename e4d hea081_4d
rename e4e hea081_4e
rename e4f hea081_4f
//final
keep id_raw zip stra year sex age zipbir zip15 edu_raw hea081_4a hea081_4b hea081_4c hea081_4d hea081_4e hea081_4f posi occ88 inco incofami edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs082
use "C:\temp\tscs082.dta", clear
keep id year stratum2 v1 age u4h v12 zip v4r v4 v7 v8 u17 u19 v9 v3 u5 u6 u4f u4cr u4fr u4c u4f u16
rename id id_raw
rename stratum2 stra
rename v1 sex
rename u4h occ88
recode v12 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v12 edu_raw //edu_rawdata
rename v4r stra15
rename v4 zip15
recode v7 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v7 v8 //dele ori_rawdata
rename u17 inco
rename u19 incofami
recode v9 (6=1)(1=2)(4 5=3)(3=4)(else=.) ,gen(mar)
drop v9 //dele mar_rawdata
rename v3 zipbir
recode u4cr (1=1)(96/max=.)(else=0),gen(occI)
rename u4f posi
rename u16 hea082_16
//final
keep id_raw zip stra year sex age zipbir zip15 edu_raw posi occ88 hea082_16 inco incofami stra15 edu_y ori_f ori_m mar occI


//tscs091
use "C:\temp\tscs091.dta", clear
keep id year stratum2 a1 age c2b5 b15b2e a9 zip a5 a6 a18 f4 f5 a13 c2e kc2e_0 c2h c2b3 b15b1cr b15b2cr c2a3r c2b3r b15b1c b15b2c c2a3 c2b3 d5 e3 e4a e4b e9a e9b e9c
rename id id_raw
rename stratum2 stra
rename a1 sex
rename c2b5 occ88
rename b15b2e occ88_f
recode a9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a9 edu_raw //edu_rawdata
recode a5 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a6 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a5 a6 //dele ori_rawdata
rename a18 reli
rename f4 inco
rename f5 incofami
recode a13 (5=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop a13 //dele mar_rawdata
//gen class
gen class1 = c2e==5 & kc2e_0>7
gen class2 = c2e==5 & kc2e_0<8
gen class3 = c2e==6
recode c2b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode c2h (96/max=.)
gen class4 = c2h!=1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = c2h!=1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = c2h==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = c2h==1 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode c2a3r (1=1)(96/max=.)(else=0),gen(occI)
rename c2b3 posi
recode b15b1cr (1=1)(96/max=.)(else=0),gen(occI_f)
rename b15b2c posi_f
rename d5 hea091_5
rename e3 hea091_3
rename e4a hea091_4a
rename e4b hea091_4b
rename e9a hea091_9a
rename e9b hea091_9b
rename e9c hea091_9c
//final
keep id_raw zip stra year sex age edu_raw reli posi_f occ88_f posi occ88 hea091_5 hea091_3 hea091_4a hea091_4b hea091_9a hea091_9b hea091_9c inco incofami edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI occI_f


//tscs092
use "C:\temp\tscs092.dta", clear
keep id year stratum2 v1 age v11g v9 v4_b v7 v8 v15 v97 v99 v6 v3br2 v3b v11f v11cr v11fr v11c v11f v92 v93 v94 v95 v96
rename id id_raw
rename stratum2 stra
rename v1 sex
rename v11g occ88
recode v9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v9 edu_raw //edu_rawdata
recode v7 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v7 v8 //dele ori_rawdata
recode v15 (31 32 33 34 35 36 37=1)(40=2)(21 22 23 24=3)(72=4)(91=5)(50=6)(60=7)(10=8)(71 73 74 75 76 77 78 81 82 83 84 85 92 93 94 95 101 102 103 110=9)(else=.) ,gen(reli)
drop v15 //dele reli_rawdata
rename v97 inco
rename v99 incofami
recode v6 (6=1)(1=2)(4 5=3)(3=4)(else=.) ,gen(mar)
drop v6 //dele mar_rawdata
rename v3br2 strabir
rename v3b zipbir
recode v11cr (1=1)(96/max=.)(else=0),gen(occI)
rename v11f posi
rename v92 hea092_92
rename v93 hea092_93
rename v94 hea092_94
rename v95 hea092_95
rename v96 hea092_96
//final
keep id_raw stra year sex age zipbir edu_raw posi occ88 hea092_92 hea092_93 hea092_94 hea092_95 hea092_96 inco incofami strabir edu_y ori_f ori_m reli mar occI

//tscs101
use "C:\temp\tscs101.dta", clear
keep id year stratum2 v1 age v101b5 v100b5 v7a zip v110 v4 v5 v11a v106 v108 v6a v6b v3 v102 v102a2 v102a2a v102b2 v101b3 v100a3r v100b5r v101a3r v101b5r v100a3 v100b3 v100b5 v101a3 v101b5 v69a v69b v69c v69d v69e v69f v69g v70a v70b v70c v70d v70e v70f v70g v72a v72b v72c v72d v72e v72f v72g v72h v72i v72j v72k v72l v73
rename id id_raw
rename stratum2 stra
rename v1 sex
rename v101b5 occ88
rename v100b5 occ88_f
recode v7a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v7a edu_raw //edu_rawdata
rename v110 zip15
rename v4 ori_f
rename v5 ori_m
rename v11a reli
recode v106 (24/max=.),gen(inco)
drop v106 //dele inco_rawdata
rename v108 incofami
recode v6a (1=1)(else=0) ,gen(mar1) 
recode v6b (1 4=2)(2 3=3)(5=4)(else=0) ,gen(mar2)
gen mar=mar1+mar2
recode mar (0=.)
drop v6a v6b mar1 mar2 //dele except mar
rename v3 zipbir
//gen class
recode v102a2a (995/max=.)
gen class1 = v102==1 & v102a2a>7
gen class2 = v102==1 & v102a2a<8
gen class3 = v102==1 & v102a2==1
recode v101b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v102b2==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v102b2==2 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v102b2==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v102b2==1 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v101a3r (1=1)(96/max=.)(else=0),gen(occI)
rename v101b3 posi
recode v100a3r (1=1)(96/max=.)(else=0),gen(occI_f)
rename v100b3 posi_f
rename v69a hea101_69a
rename v69b hea101_69b
rename v69c hea101_69c
rename v69d hea101_69d
rename v69e hea101_69e
rename v69f hea101_69f
rename v69g hea101_69g
rename v70a hea101_70a
rename v70b hea101_70b
rename v70c hea101_70c
rename v70d hea101_70d
rename v70e hea101_70e
rename v70f hea101_70f
rename v70g hea101_70g
rename v72a hea101_72a
rename v72b hea101_72b
rename v72c hea101_72c
rename v72d hea101_72d
rename v72e hea101_72e
rename v72f hea101_72f
rename v72g hea101_72g
rename v72h hea101_72h
rename v72i hea101_72i
rename v72j hea101_72j
rename v72k hea101_72k
rename v72l hea101_72l
rename v73 hea101_73
//final
keep id_raw zip stra year sex age zipbir ori_f ori_m edu_raw reli hea101_69a hea101_69b hea101_69c hea101_69d hea101_69e hea101_69f hea101_69g hea101_70a hea101_70b hea101_70c hea101_70d hea101_70e hea101_70f hea101_70g hea101_72a hea101_72b hea101_72c hea101_72d hea101_72e hea101_72f hea101_72g hea101_72h hea101_72i hea101_72j hea101_72k hea101_72l hea101_73 posi_f occ88_f posi occ88 incofami zip15 edu_y inco mar class1 class2 class3 class4 class5 class6 class7 occI occI_f


//tscs102
use "C:\temp\tscs102.dta", clear
keep id year stratum2 v1 age v93b5 v9 zip v7 v8 v12 v106 v107 v5 v91 v91b v92 v93b3 v93a3r v93b5r v93a3 v82c v83c v84c v85c v86c v87c v88c v82d v83d v84d v85d v86d v87d v88d
rename id id_raw
rename stratum2 stra
rename v1 sex
rename v93b5 occ88
recode v9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v9 edu_raw //edu_rawdata
recode v7 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop v7 v8 //dele ori_rawdata
rename v12 reli
rename v106 inco
rename v107 incofami
recode v5 (6=1)(1=2)(4 5=3)(3=4)(else=.) ,gen(mar)
drop v5 //dele mar_rawdata
//gen class
recode v91b (9992/max=.)
gen class1 = v91==3 & v91b>7
gen class2 = v91==3 & v91b<8
gen class3 = v91==2 
recode v93b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = v92==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v92==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v92==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v92==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v93a3r (1=1)(96/max=.)(else=0),gen(occI)
rename v93b3 posi
rename v82c hea102_82c
rename v83c hea102_83c
rename v84c hea102_84c
rename v85c hea102_85c
rename v86c hea102_86c
rename v87c hea102_87c
rename v88c hea102_88c
rename v82d hea102_82d
rename v83d hea102_83d
rename v84d hea102_84d
rename v85d hea102_85d
rename v86d hea102_86d
rename v87d hea102_87d
rename v88d hea102_88d
//final
keep id_raw zip stra year sex age edu_raw reli hea102_82c hea102_83c hea102_84c hea102_85c hea102_86c hea102_87c hea102_88c hea102_82d hea102_83d hea102_84d hea102_85d hea102_86d hea102_87d hea102_88d posi occ88 inco incofami edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs111
use "C:\temp\tscs111.dta", clear
keep id year stratum2 a1 a2y k5b5 a11 zip k2ar k2a a3 a4 k1 k11 k12 a6 k5b4 k5d k5e k5f k5a3r k5b5r k5a3 a5 g4 g5 g6 k7
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (98/max=.)
gen age=100-a2y
drop a2y //dele birth_y_rawdata
rename k5b5 occ88
recode a11 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a11 edu_raw //edu_rawdata
rename k2ar stra15
rename k2a zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_f)
recode a4 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.),gen(ori_m)
drop a3 a4 //dele ori_rawdata
rename k1 reli
rename k11 inco
rename k12 incofami
recode a6 (6=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop a6 //dele mar_rawdata
//gen class
recode k5f (9992/max=.)
gen class1 = k5e==1 & k5f>7
gen class2 = k5e==1 & k5f<8
gen class3 = k5e==4 
recode k5b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = k5d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = k5d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = k5d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = k5d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode k5a3r (1=1)(93/max=.)(else=0),gen(occI)
rename k5b4 posi
rename a5 hea111_a5
rename g4 hea111_g4
rename g5 hea111_g5
rename g6 hea111_g6
rename k7 hea111_k7
//final
keep id_raw zip stra year sex hea111_a5 edu_raw hea111_g4 hea111_g5 hea111_g6 reli zip15 posi occ88 hea111_k7 inco incofami stra15 age edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs112
use "C:\temp\tscs112.dta", clear
keep id year stratum2 gender birth_y h6b5 g14 zip z0b_zipr g27 g28 g12 h20 h19 g17 z0a_zipr h4 h4b h5 h6b3 h6a3r h6b5r h6a3 d11a d19a d11b d19b d20 d21a d21b d22a d22b d22c d22d d22e d22f g6 g7a g7b
rename id id_raw
rename stratum2 stra
rename gender sex
recode birth_y (97/max=.)
gen age=100-birth_y
drop birth_y //dele birth_y_rawdata
rename h6b5 occ88
recode g14 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename g14 edu_raw //edu_rawdata
rename z0b_zipr stra15
rename g27 ori_f
rename g28 ori_m
rename g12 reli
recode h20 (24/max=.),gen(inco)
drop h20 //dele inco_rawdata
rename h19 incofami
recode g17 (6=1)(1=2)(4 5=3)(3=4)(else=.) ,gen(mar)
drop g17 //dele mar_rawdata
rename z0a_zipr strabir
//gen class
recode h4b (992/max=.)
gen class1 = h4==3 & h4b>7
gen class2 = h4==3 & h4b<8
gen class3 = h4==2 
recode h6b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = h5==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = h5==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = h5==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = h5==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode h6a3r (1=1)(93/max=.)(else=0),gen(occI)
rename h6b3 posi
rename d11a hea112_11a
rename d19a hea112_19a
rename d11b hea112_11b
rename d19b hea112_19b
rename d20 hea112_20
rename d21a hea112_21a
rename d21b hea112_21b
rename d22a hea112_22a
rename d22b hea112_22b
rename d22c hea112_22c
rename d22d hea112_22d
rename d22e hea112_22e
rename d22f hea112_22f
rename g6 hea112_6
rename g7a hea112_7a
rename g7b hea112_7b
//final
keep id_raw zip stra year sex hea112_11a hea112_11b hea112_19a hea112_19b hea112_20 hea112_21a hea112_21b hea112_22a hea112_22b hea112_22c hea112_22d hea112_22e hea112_22f hea112_6 hea112_7a hea112_7b reli edu_raw ori_f ori_m posi occ88 incofami strabir stra15 age edu_y inco mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs121
use "C:\temp\tscs121.dta", clear
keep id year stratum2 v1 v2y v49b5 v25b5 v11 zip v4_zip v8 v9 v10 v106 v108 v14 v3_zip v36 v37 v38 v26 v27 v28 v34a3 v34b3 v49a3 v25a3 v25b3 v103 v104 v105a v105b v105c v105d
rename id id_raw
rename stratum2 stra
rename v1 sex
recode v2y (0 97/max=.)
gen age=101-v2y
drop v2y //dele birth_y_rawdata
rename v49b5 occ08
rename v25b5 occ88_f
recode v11 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v11 edu_raw //edu_rawdata
rename v4_zip zip15
rename v8 ori_f
rename v9 ori_m
rename v10 reli
recode v106 (24/max=.),gen(inco)
drop v106 //dele inco_rawdata
rename v108 incofami
recode v14 (1=1)(2=2)(4 5=3)(6=4)(else=.) ,gen(mar)
drop v14 //dele mar_rawdata
rename v3_zip zipbir
//gen class
recode v37 (97/max=.)
gen class1 = v36==2 & v37>3
gen class2 = v36==2 & v37<3
gen class3 = v36==3 
recode v34b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode v38 (9997/max=.)
gen class4 = v38!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v38!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v38==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v38==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
//gen class_f
recode v27 (1=0)(2=1)(4/9=2)(else=.),gen(staff)
gen class1f = v26==2 & staff==2
gen class2f = v26==2 & staff==1
gen class3f = v26==3 
recode v25b3 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(classf_)
gen class4f = v28==1 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class5f = v28==1 & classf_ ==2 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class6f = v28==2 & classf_ ==1 & class1f!=1 & class2f!= 1 & class3f!= 1 
gen class7f = v28==2 & classf_ ==3 & class1f!=1 & class2f!= 1 & class3f!= 1 

recode v34a3 (10 20 30 = 1)(50/990=0)(997/max=.),gen(occI)
rename v34b3 posi
recode v25a3 (10 20 30 = 1)(50/990=0)(997/max=.),gen(occI_f)
rename v25b3 posi_f
drop v34a3 v25a3 //dele occI_rawdata
rename v103 hea121_103
rename v104 hea121_104
rename v105a hea121_105a
rename v105b hea121_105b
rename v105c hea121_105c
rename v105d hea121_105d
//final
keep id_raw zip stra year sex zipbir zip15 ori_f ori_m reli edu_raw posi_f occ88_f posi occ08 hea121_103 hea121_104 hea121_105a hea121_105b hea121_105c hea121_105d incofami age edu_y inco mar class1 class2 class3 class4 class5 class6 class7 class1f class2f class3f class4f class5f class6f class7f occI occI_f


//tscs122
use "C:\temp\tscs122.dta", clear
keep id year stratum2 a1 a2y c3b5 b1 zip a7_zip a3 a4 a5 k2 k5 a10 c3e c3e1 c3f c3b4 c3a3 e27 e28 e29 e30
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (0 97/max=.)
gen age=101-a2y
drop a2y //dele birth_y_rawdata
rename c3b5 occ88
recode b1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename b1 edu_raw //edu_rawdata
rename a7_zip zip15
rename a3 ori_f
rename a4 ori_m
rename a5 reli
recode k2 (2=1)(3=2)(4=3)(5=4)(6=5)(7=6)(8=7)(9=8)(10=9)(11=10)(12=11)(13=12)(14=13)(15=14)(16=15)(17=16)(18=17)(19=18)(20=19)(21=20)(22=21)(23=22)(24=23)(1 97 98=.),gen(inco)
drop k2 //dele inco_rawdata
recode a10 (1=1)(3=2)(4 5=3)(6=4)(else=.) ,gen(mar)
drop a10 //dele mar_rawdata
//gen class
recode c3e1 (9992/max=.)
gen class1 = c3e==1 & c3e1>7
gen class2 = c3e==1 & c3e1<8
gen class3 = c3e==2 
recode c3b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = c3f==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = c3f==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = c3f==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = c3f==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode c3a3 (10 20 30 = 1)(50/990=0)(997/max=.),gen(occI)
rename c3b4 posi
drop c3a3 //dele occI_rawdata
rename e27 hea122_27
rename e28 hea122_28
rename e29 hea122_29
rename e30 hea122_30
//final
keep id_raw zip stra year sex ori_f ori_m reli zip15 edu_raw posi occ88 hea122_27 hea122_28 hea122_29 hea122_30 age edu_y inco mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs131
use "C:\temp\tscs131.dta", clear
keep id year stratum2 v1 v2y v102b5 v8 zip v5 v6 v7 v104 v105 v10 v102e v102e1 v102f v102b4 v102a3 v93 v94 v95 v96a v96b v96c
rename id id_raw
rename stratum2 stra
rename v1 sex
recode v2y (996/max=.)
gen age=102-v2y
drop v2y //dele birth_y_rawdata
rename v102b5 occ88
recode v8 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v8 edu_raw //edu_rawdata
rename v5 ori_f
rename v6 ori_m
recode v7 (1 2=1)(3=2)(4=3)(5=4)(6=5)(7=6)(8=7)(9=8)(10=9)(else=.) ,gen(reli)
drop v7 //dele reli_rawdata
rename v104 inco
rename v105 incofami
recode v10 (1=1)(2=2)(4 5=3)(6=4)(else=.) ,gen(mar)
drop v10 //dele mar_rawdata
//gen class
recode v102e1 (9992/max=.)
gen class1 = v102e==1 & v102e1>7
gen class2 = v102e==1 & v102e1<8
gen class3 = v102e==2 
recode v102b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode v102f (9992/max=.)
gen class4 = v102f!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v102f!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v102f==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v102f==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v102a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename v102b4 posi
drop v102a3 //dele occI_rawdata
rename v93 hea131_93
rename v94 hea131_94
rename v95 hea131_95
rename v96a hea131_96a
rename v96b hea131_96b
rename v96c hea131_96c
//final
keep id_raw zip stra year sex ori_f ori_m edu_raw hea131_93 hea131_94 hea131_95 hea131_96a hea131_96b hea131_96c posi occ88 inco incofami age edu_y reli mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs132
use "C:\temp\tscs132.dta", clear
keep id year stratum2 v1 v2y v102b5 v21 zip v13 v8 v11 v19 v110 v111 v25 v3zip v102b4 v102d v102d1 v102e v102a3 
rename id id_raw
rename stratum2 stra
rename v1 sex
recode v2y (96/max=.)
gen age=102-v2y
drop v2y //dele birth_y_rawdata
rename v102b5 occ88
recode v21 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v21 edu_raw //edu_rawdata
recode v13 (1=1)(2=2)(3=3)(4 6=4)(5 7 8=5)(else=.),gen(ori)
recode v8 (1=1)(2=2)(3=3)(4 6=4)(5 7 8=5)(else=.),gen(ori_f)
recode v11 (1=1)(2=2)(3=3)(4 6=4)(5 7 8=5)(else=.),gen(ori_m)
drop v13 v8 v11 //dele ori_rawdata
recode v19 (1 2=1)(3=2)(4=3)(5=4)(6=5)(7=6)(8=7)(9=8)(10=9)(else=.) ,gen(reli)
drop v19 //dele reli_rawdata
rename v110 inco
rename v111 incofami
recode v25 (1=1)(2 3=2)(5 6=3)(7=4)(else=.) ,gen(mar)
drop v25 //dele mar_rawdata
rename v3zip zipbir
//gen class
recode v102d1 (9992/max=.)
gen class1 = v102d==1 & v102d1>7
gen class2 = v102d==1 & v102d1<8
gen class3 = v102d==2 
recode v102b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode v102e (9992/max=.)
gen class4 = v102e!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v102e!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v102e==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v102e==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v102a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename v102b4 posi
drop v102a3 //dele occI_rawdata
//final
keep id_raw zip stra year sex zipbir edu_raw posi occ88 inco incofami age edu_y ori ori_f ori_m reli mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs141
use "C:\temp\tscs141.dta", clear
keep id year stratum2 a1 a2y j4b5 j4b5_r b1 zip a4zip a11 a7 a9 a12 j16 j17 b3 a3zip j4b4 j5 j5a j6 j4a3 g14
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (96/max=.)
gen age=103-a2y
drop a2y //dele birth_y_rawdata
rename j4b5 occ08
rename j4b5_r occ88
recode b1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename b1 edu_raw //edu_rawdata
rename a4zip zip15
recode a11 (1=1)(2=2)(3=3)(4=4)(5 6 7 8=5)(else=.),gen(ori)
recode a7 (1=1)(2=2)(3=3)(4=4)(5 6 7 8=5)(else=.),gen(ori_f)
recode a9 (1=1)(2=2)(3=3)(4=4)(5 6 7 8=5)(else=.),gen(ori_m)
drop a11 a7 a9 //dele ori_rawdata
recode a12 (1 2=1)(3=2)(4=3)(5=4)(6=5)(7=6)(8=7)(9=8)(10=9)(else=.) ,gen(reli)
drop a12 //dele reli_rawdata
rename j16 inco
rename j17 incofami
recode b3 (1=1)(2 3=2)(5 6=3)(7=4)(else=.) ,gen(mar)
drop b3 //dele mar_rawdata
rename a3zip zipbir
//gen class
recode j5a (99992/max=.)
gen class1 = j5==1 & j5a>7
gen class2 = j5==1 & j5a<8
gen class3 = j5==2 
recode j4b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode j6 (99992/max=.)
gen class4 = j6!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = j6!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = j6==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = j6==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode j4a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename j4b4 posi
drop j4a3 //dele occI_rawdata
rename g14 hea141_14
//final
keep id_raw zip stra year sex zipbir zip15 edu_raw hea141_14 posi occ08 occ88 inco incofami age edu_y ori ori_f ori_m ori_m reli mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs142
use "C:\temp\tscs142.dta", clear
keep id year stratum2 v1 v2y v11b5 v11b5_r v9 zip v7 v8 v15 v80 v82 v6 v3zip v11b4 v11a3 v75 v76 v77 v79
rename id id_raw
rename stratum2 stra
rename v1 sex
recode v2y (97/max=.)
gen age=103-v2y
drop v2y //dele birth_y_rawdata
rename v11b5 occ08
rename v11b5_r occ88
recode v9 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v9 edu_raw //edu_rawdata
recode v7 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.) ,gen(ori_f)
recode v8 (1=1)(2=2)(4=3)(3=4)(5=5)(else=.) ,gen(ori_m)
drop v7 v8 //dele ori_rawdata
recode v15 (31 32 33 34 35 36 37=1)(40=2)(21 22 23 24=3)(72=4)(91=5)(50=6)(60=7)(10=8)(71 73 74 75 76 77 78 81 82 83 84 85 92 93 94 95 101 102 103 110=9)(else=.) ,gen(reli)
drop v15 //dele reli_rawdata
rename v80 inco
rename v82 incofami
recode v6 (6=1)(1=2)(4 5=3)(3=4)(else=.) ,gen(mar)
drop v6 //dele mar_rawdata
rename v3zip zipbir
recode v11a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename v11b4 posi
drop v11a3 //dele occI_rawdata
rename v75 hea142_75
rename v76 hea142_76
rename v77 hea142_77
rename v79 hea142_79
//final

//tscs151
use "C:\temp\tscs151.dta", clear
keep id year stratum2 v1 v2y v99b5 v99b588 v98b5 v98b588 v6a zip v110zip v4 v5 v11 v106 v108 v7 v3zip v101 v101a1 v101b2 v99b4 v98a3 v98b4 v99a3 v71a v71b v71c v71d v71e v71f v72a v72b v72c v72d v72e v72f v72g v72h v72i v72j v72k v72l v73 
rename id id_raw
rename stratum2 stra
rename v1 sex
recode v2y (96/max=.)
gen age=104-v2y
drop v2y //dele birth_y_rawdata
rename v99b5 occ08
rename v99b588 occ88
rename v98b5 occ08_f
rename v98b588 occ88_f
recode v6a (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename v6a edu_raw //edu_rawdata
rename v110zip zip15
rename v4 ori_f
rename v5 ori_m
recode v11 (1=1)(2=2)(3=3)(4=4)(6=5)(7=6)(8=7)(10=8)(5=9)(9=9)(10=9)(11=9)(96/max=.) ,gen(reli)
drop v11 //dele reli_rawdata
rename v106 inco
rename v108 incofami
recode v7 (1=1)(2 3 4=2)(6 7=3)(8=4)(else=.) ,gen(mar)
drop v7 //dele mar_rawdata
rename v3zip zipbir
//gen class
recode v101a1 (9992/max=.)
gen class1 = v101<3 & v101a1>7
gen class2 = v101<3 & v101a1<8
gen class3 = v101<3 & v101a1==0 
recode v99b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode v101b2 (9992/max=.)
gen class4 = v101b2!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = v101b2!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = v101b2==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = v101b2==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode v99a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename v99b4 posi
recode v98a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI_f)
rename v98b4 posi_f
drop v99a3 v98a3 //dele occI_rawdata
rename v71a hea151_71a
rename v71b hea151_71b
rename v71c hea151_71c
rename v71d hea151_71d
rename v71e hea151_71e
rename v71f hea151_71f
rename v72a hea151_72a
rename v72b hea151_72b
rename v72c hea151_72c
rename v72d hea151_72d
rename v72e hea151_72e
rename v72f hea151_72f
rename v72g hea151_72g
rename v72h hea151_72h
rename v72i hea151_72i
rename v72j hea151_72j
rename v72k hea151_72k
rename v72l hea151_72l
rename v73 hea151_73
//final
keep id_raw zip stra year sex zipbir ori_f ori_m edu_raw hea151_71a hea151_71b hea151_71c hea151_71d hea151_71e hea151_71f hea151_72a hea151_72b hea151_72c hea151_72d hea151_72e hea151_72f hea151_72g hea151_72h hea151_72i hea151_72j hea151_72k hea151_72l hea151_73 posi_f occ08_f posi occ08 inco incofami zip15 occ88_f occ88 age edu_y reli mar class1 class2 class3 class4 class5 class6 class7 occI occI_f


//tscs152
use "C:\temp\tscs152.dta", clear
keep id year stratum2 a1 a2y c3b5 c3b5r b1 zip a3 a5 a7 t3 t5 a11 c3b4 c3f kc3f1 c3g c3a3 q1a q1b q1c q2 q3 q4 q5 q6
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (97/max=.)
gen age=104-a2y
drop a2y //dele birth_y_rawdata
rename c3b5 occ08
rename c3b5r occ88
recode b1 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename b1 edu_raw //edu_rawdata
rename a3 ori_f
rename a5 ori_m
rename a7 reli
rename t3 inco
rename t5 incofami
recode a11 (1=1)(2 3=2)(5 6=3)(7=4)(else=.) ,gen(mar)
drop a11 //dele mar_rawdata
//gen class
recode kc3f1 (996/max=.)
gen class1 = c3f==1 & kc3f1>7
gen class2 = c3f==1 & kc3f1<8
gen class3 = c3f==2
recode c3b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode c3g (99996/max=.)
gen class4 = c3g!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = c3g!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = c3g==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = c3g==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode c3a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename c3b4 posi
drop c3a3 //dele occI_rawdata
rename q1a hea152_1a
rename q1b hea152_1b
rename q1c hea152_1c
rename q2 hea152_2
rename q3 hea152_3
rename q4 hea152_4
rename q5 hea152_5
rename q6 hea152_6
//final
keep id_raw zip stra year sex ori_f ori_m reli edu_raw posi occ08 occ88 hea152_1a hea152_1b hea152_1c hea152_2 hea152_3 hea152_4 hea152_5 hea152_6 inco incofami age edu_y mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs161
use "C:\temp\tscs161.dta", clear
keep id year stratum2 a1 a2y k5b5 k5b5isco88 a10 zip k2zip a3 a4 k1 k9 k10 a5 k5e k5f k5d k5b4 k5a3 g1 g1a g2a g6 g7
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (96/max=.)
gen age=105-a2y
drop a2y //dele birth_y_rawdata
rename k5b5 occ08
rename k5b5isco88 occ88
recode a10 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a10 edu_raw //edu_rawdata
rename k2zip zip15
recode a3 (1=1)(2=2)(4=3)(3=4)(5 6 7=5)(else=.) ,gen(ori_f)
recode a4 (1=1)(2=2)(4=3)(3=4)(5 6 7=5)(else=.) ,gen(ori_m)
drop a3 a4 //dele ori_rawdata
rename k1 reli
rename k9 inco
rename k10 incofami
recode a5 (6=1)(1=2)(3 4=3)(2=4)(else=.) ,gen(mar)
drop a5 //dele mar_rawdata
//gen class
recode k5f (99996/max=.)
gen class1 = k5e==1 & k5f>7
gen class2 = k5e==1 & k5f<8
gen class3 = k5e==4
recode k5b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
gen class4 = k5d==1 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = k5d==1 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = k5d==2 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = k5d==2 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode k5a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename k5b4 posi
drop k5a3 //dele occI_rawdata
rename g1 hea161_1
rename g1a hea161_1a
rename g2a hea161_2a
rename g6 hea161_6
rename g7 hea161_7
//final
keep id_raw zip stra year sex edu_raw hea161_1 hea161_1a hea161_2a hea161_6 hea161_7 reli zip15 posi occ08 occ88 inco incofami age edu_y ori_f ori_m mar class1 class2 class3 class4 class5 class6 class7 occI


//tscs162
use "C:\temp\tscs162.dta", clear
keep id year stratum2 a1 a2y j6b5 j6b5_88 a13 zip a9 a5 a7 a11 j16 j17 a10 j7 j7a j8 j6b4 j6a3
rename id id_raw
rename stratum2 stra
rename a1 sex
recode a2y (96/max=.)
gen age=105-a2y
drop a2y //dele birth_y_rawdata
rename j6b5 occ08
rename j6b5_88 occ88
recode a13 (1=0)(2=3)(3=6)(4 5=9)(6 9=12)(10 11=14)(12=15)(13 14 15=14)(16 17 18 19=16)(20=18)(21=20)(22/max=.) ,gen(edu_y)
rename a13 edu_raw //edu_rawdata
rename a9 ori
rename a5 ori_f
rename a7 ori_m
rename a11 reli
rename j16 inco
rename j17 incofami
recode a10 (1=1)(2 3=2)(5 6=3)(7=4)(else=.) ,gen(mar)
drop a10 //dele mar_rawdata
//gen class
recode j7a (9996/max=.)
gen class1 = j7==1 & j7a>7
gen class2 = j7==1 & j7a<8
gen class3 = j7==2
recode j6b4 (200/399=1)(100/199=2)(910/960=3)(else=.),gen(class_)
recode j8 (9996/max=.)
gen class4 = j8!=0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class5 = j8!=0 & class_ ==2 & class1!=1 & class2!= 1 & class3!= 1 
gen class6 = j8==0 & class_ ==1 & class1!=1 & class2!= 1 & class3!= 1 
gen class7 = j8==0 & class_ ==3 & class1!=1 & class2!= 1 & class3!= 1 
recode j6a3 (10 20 30 = 1)(50/990=0)(996/max=.),gen(occI)
rename j6b4 posi
drop j6a3 //dele occI_rawdata
//final
keep id_raw zip stra year sex ori_f ori_m ori reli edu_raw posi occ08 occ88 inco incofami age edu_y mar class1 class2 class3 class4 class5 class6 class7 occI


//append
cd c:\temp
use 180917b, clear
append using tscs001
append using tscs002
append using tscs011
append using tscs012
append using tscs013
append using tscs021
append using tscs022
append using tscs031
append using tscs032
append using tscs041
append using tscs042
append using tscs051
append using tscs052
append using tscs061
append using tscs062
append using tscs071
append using tscs072
append using tscs081
append using tscs082
append using tscs091
append using tscs092
append using tscs101
append using tscs102
append using tscs111
append using tscs112
append using tscs121
append using tscs122
append using tscs131
append using tscs132
append using tscs141
append using tscs142
append using tscs151
append using tscs152
append using tscs161
append using tscs162
drop id

//create id
sort year
by year: gen idnum=_n
tostring year, gen(year_)
tostring idnum, gen(id_)
gen id=year_+"_"+id_
drop idnum year_ id_

//gen class class_f
recode class2 (1=2)
recode class3 (1=3)
recode class4 (1=4)
recode class5 (1=5)
recode class6 (1=6)
recode class7 (1=7)
gen class=class1+class2+class3+class4+class5+class6+class7
recode class2f (1=2)
recode class3f (1=3)
recode class4f (1=4)
recode class5f (1=5)
recode class6f (1=6)
recode class7f (1=7)
gen class_f=class1f+class2f+class3f+class4f+class5f+class6f+class7f
recode class(0=.)
recode class_f(0=.)

//gen occp ses ses5 occp_f ses_f ses5_f
recode posi (110=80.8)(120 130 140=83.8)(201=89.8)(202=82.6)(211 221=87.3)(212 213 214=77.7)(222 223=78.4)(230=85.1)(250=82.0)(301 302 303=80.6)(311=82.1)(312 314=75.0)(313=74.7)(321 322 340=78.1)(331=79.1)(332=76.0)(350 360=78.9)(370=80.2)(410=76.6)(420 511=70.0)(431=75.6)(432=75.1)(512 514=66.6)(513=72.4)(515 516=76.0)(520=79.0)(531=73.1)(532=67.7)(610=68.6)(620=64.7)(710=72.7)(720=74.7)(790=71.6)(810 840=70.0)(820=70.6)(830=70.3)(910=65.1)(920=69.9)(930=63.6)(940=66.2)(950=64.1)(960=67.1)(else=.),gen(occp)
recode posi (110=83.3)(120 130 140=81.4)(201=87.9)(202=81.1)(211 221=86.0)(212 213 214=80.0)(222 223=79.1)(230=85.1)(250=83.2)(301 302 303=78.4)(311=80.1)(312 314=74.5)(313=78.1)(321 322 340=77.5)(331=78.8)(332=77.2)(350 360=80.1)(370=81.9)(410=76.5)(420 511=74.3)(431=76.0)(432=76.7)(512 514=66.8)(513=68.9)(515 516=73.1)(520=76.9)(531=71.8)(532=67.3)(610=66.0)(620=65.9)(710=72.0)(720=74.2)(790=71.1)(810 840=70.7)(820=70.8)(830=69.4)(910=66.1)(920=71.0)(930=65.7)(940=64.5)(950=64.6)(960=69.6)(else=.),gen(ses)
recode posi (110 120 130 140 370=1)(201/250=2)(301/360=3)(410/432=4)(511/532=5)(610/620=6)(710/790=7)(810/840=8)(910/960=9)(060/067=10)(068=11)(069=12)(070 071=13)(996/999=.),gen(posi9)
recode posi9 (1 2=5)(3=4)(4=3)(5 7 8=2)(6 9=1),gen(ses5)

recode posi_f (110=80.8)(120 130 140=83.8)(201=89.8)(202=82.6)(211 221=87.3)(212 213 214=77.7)(222 223=78.4)(230=85.1)(250=82.0)(301 302 303=80.6)(311=82.1)(312 314=75.0)(313=74.7)(321 322 340=78.1)(331=79.1)(332=76.0)(350 360=78.9)(370=80.2)(410=76.6)(420 511=70.0)(431=75.6)(432=75.1)(512 514=66.6)(513=72.4)(515 516=76.0)(520=79.0)(531=73.1)(532=67.7)(610=68.6)(620=64.7)(710=72.7)(720=74.7)(790=71.6)(810 840=70.0)(820=70.6)(830=70.3)(910=65.1)(920=69.9)(930=63.6)(940=66.2)(950=64.1)(960=67.1)(else=.),gen(occp_f)
recode posi_f (110=83.3)(120 130 140=81.4)(201=87.9)(202=81.1)(211 221=86.0)(212 213 214=80.0)(222 223=79.1)(230=85.1)(250=83.2)(301 302 303=78.4)(311=80.1)(312 314=74.5)(313=78.1)(321 322 340=77.5)(331=78.8)(332=77.2)(350 360=80.1)(370=81.9)(410=76.5)(420 511=74.3)(431=76.0)(432=76.7)(512 514=66.8)(513=68.9)(515 516=73.1)(520=76.9)(531=71.8)(532=67.3)(610=66.0)(620=65.9)(710=72.0)(720=74.2)(790=71.1)(810 840=70.7)(820=70.8)(830=69.4)(910=66.1)(920=71.0)(930=65.7)(940=64.5)(950=64.6)(960=69.6)(else=.),gen(ses_f)
recode posi_f (110 120 130 140 370=1)(201/250=2)(301/360=3)(410/432=4)(511/532=5)(610/620=6)(710/790=7)(810/840=8)(910/960=9)(060/067=10)(068=11)(069=12)(070 071=13)(996/999=.),gen(posi9_f)
recode posi9_f (1 2=5)(3=4)(4=3)(5 7 8=2)(6 9=1),gen(ses5_f)

//labeling

label define sex 1 "1_male" 2 "2_female"
label value sex sex

label define stra 1"1_都會核心" 2 "2_工商市區" 3 "3_新興市鎮" 4 "4_傳統產業市鎮" 5"5_低度發展鄉鎮" 6 "6_高齡化偏遠鄉鎮"
label value stra stra
label value strabir stra
label value stra15 stra

label define ori 1 "1_台灣閩南" 2 "2_台灣客家" 3 "3_台灣原住民" 4 "4_大陸各省市" 5"5_其他"
label value ori ori
label value ori_f ori
label value ori_m ori

label define reli 1"1_佛教" 2"2_道教" 3"3_民間信仰" 4"4_一貫道" 5"5_回教" 6"6_天主教" 7"7_基督教" 8"8_沒有宗教信仰" 9"9_其他"
label value reli reli

label define mar 1"1_單身未婚" 2"2_已婚有偶" 3"3_離婚或分居" 4"4_喪偶"
label value mar mar

label define occI 0"0_非一級產業" 1"1_一級產業"
label value occI occI
label value occI_f occI
