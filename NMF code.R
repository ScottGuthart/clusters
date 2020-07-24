#note- install these packages if you don't have them
install.packages("psych")
install.packages("caret")
install.packages("NMF")
install.packages("mclust")
install.packages("fpc")
install.packages("doBy")
library(psych)
library(caret)
library(NMF)
library(mclust)
library(fpc)
library(doBy)


#pull in your datafile
# NMF can't handle a respondent with all 0s so you will need to account for that when pulling in your data
# NMF can handle any non-negative data

Telaria=read.csv("T:\\2019\\18-1501 Telaria DTC\\18-1501 telaria q36raw.csv")
Telaria=as.data.frame(Telaria)
#edit the 2:70 to reference the columns where your data is stored. Edit 4 to be equal to number of segments
nmf_Telaria<-nmf(Telaria[ ,2:18], 4, "lee",  seed = 141141, nrun = 50)
nmf_Telaria.df <- data.frame(nmf_Telaria)
#this will load the heat map- shows how respondents load onto segment
basismap(nmf_Telaria,tracks="basis")
W_Telaria<-basis(nmf_Telaria)

#this shows how attributes group together
HTelaria<-coef(nmf_Telaria)
round(t(HTelaria),2)

#Codes maximum loading to be = segment membership
NMF_Seg_Telaria.df<-data.frame(NMF_Telaria=max.col(W_Telaria))
#see segment sizes
table(NMF_Seg_Telaria.df)
#save out results
write.csv(NMF_Seg_Telaria.df,"T:\\2019\\18-1501 Telaria DTC\\18-1501 telaria q36raw_4clust.csv")
