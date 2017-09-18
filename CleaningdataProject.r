# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

#  Merge training & test data sets
setwd("C:/Users/kkolaro/Desktop/Private/ucenje/Coursera/getting and cleaning data/Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

temp1 <- fread("./train/X_train.txt")

temp2 <- fread ("./test/X_test.txt")

XTT <- rbind(temp1, temp2)

temp1 <- fread("./train/subject_train.txt")

temp2 <- fread("./test/subject_test.txt")

ST<- rbind(temp1, temp2)

temp1 <- fread("./train/y_train.txt")

temp2 <- fread("./test/y_test.txt")

YTT <- rbind(temp1, temp2)

#extract only mean and sd measurements , giving self expalnatory  column names 

fts <- read.table("features.txt")
mest_positions<- grep("-mean\\(\\)|-std\\(\\)", fts[, 2])
XTT<-as.data.frame(XTT)
XTT<-XTT[,mest_positions]
names(XTT)<-fts[mest_positions,2]
names(XTT)<-toupper(gsub("\\(|\\)","",names(XTT)))
#
activi<-read.table("activity_labels.txt")
activi<-as.data.table(activi)
setkey(activi, V1)
setkey(YTT,V1)
YTT<-merge(activi,YTT)
names(YTT)<-c("Index","Activity")

names(ST)<-"Subject"
tidydata<-cbind(ST,YTT,XTT)
write.table(tidydata,"tidydata.txt")

#  creates a second, independent tidy data set with the average of each variable for 
#  each activity and each subject.

uniquesubjects<-unique(ST)
nmbrsubjects<-length(uniquesubjects$Subject)
uniqactivities<-length(unique(YTT$Activity))
nmbrcol<-ncol(tidydata)
tidydata1<-tidydata[1:(nmbrsubjects*uniqactivities),]
tidydata1<-as.data.frame(tidydata1)
activi<-as.data.frame(activi)
uniqsubjects<-as.data.frame(uniqsubjects)
tidydata<-as.data.frame(tidydata)
row=1
for (a in 1:uniqactivities) {
  for(s in 1:nmbrsubjects){
    tidydata1[row,1]=uniqsubjects[s,1]
    tidydata1[row,2]=activi[a,1]
    tidydata1[row,3]=activi[a,2]
    
    temp <- tidydata[tidydata$Subject==s&tidydata$Index==activi[a, 1], ]
    tidydata1[row, 4:nmbrcol] <- colMeans(temp[, 4:nmbrcol])
    row=row+1
  }
}
write.table(tidydata1,"tydydata1.txt")
