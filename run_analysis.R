#read activity labels
activityLabel <- read.table('activity_labels.txt')
activityCode <- activityLabel$V1
activityName <- activityLabel$V2

#read features labels
features <- read.table("features.txt")
meanStdCol <-  features[grepl(".*mean|std.*", features[,"V2"]),]
meanStdColNumber <-meanStdCol$V1
meanStdColNames <- meanStdCol$V2

#read test data
test <-read.table("test/X_test.txt")
#remove non mean and std cols
test <-test[,meanStdColNumber]
#add descriptive column name
names(test) <- meanStdColNames
#read test data subject
testSubject <-read.table("test/subject_test.txt")
#add subject column label
names(testSubject) <- "subject"
#add subject column to test data
test <- cbind(testSubject, test)


#read training data
train <-read.table("train/X_train.txt")
#remove non mean and std cols
train <-train[,meanStdColNumber]
#add descriptive column name
names(train) <- meanStdColNames
#read train data subject
trainSubject <-read.table("train/subject_train.txt")
#add subject column label
names(trainSubject) <- "subject"
#add subject column to train data
train <- cbind(trainSubject, train)

#merge test and train data
tidyDataSet1 <- merge(test,train, all=T)
#add activity code column
activityId <- rep(activityCode, length.out=length(tidyDataSet1$subject))
names(activityId) <- "ActivityId"
#add the activityId column to the merge data
tidyDataSet1 <- cbind(activityId, tidyDataSet1)
#add descriptive activity column name
activityDescription <- rep(activityName, length.out=length(tidyDataSet1$subject))
names(activityDescription) <- "ActivityName"
#add the activityDescription column to the merge data
tidyDataSet1 <- cbind(activityDescription, tidyDataSet1)

#writes out tidy data set #1
write.csv(tidyDataSet1, file="tidyDataSet1.txt", row.names = F)

#create tidy data set # 2
#slice by activity
activity <- split(tidyDataSet1,activityDescription)
tidyDataSet2 <- list()
for(i in activityCode){
  #split by subject
  actName <- names(activity[i])
  df <- data.frame(activity[i])
  activityBySubject <- split(df, as.factor(df[,3]))
  for(j in 1:length(activityBySubject)){
    subName <- names(activityBySubject[j])
    rowName <- paste(actName, "subject", subName,  sep=".")
    outRow <- lapply(activityBySubject[j], function(x) colMeans(data.frame(x)[, 1:length(meanStdColNumber) + 3]))
    names(outRow) <- rowName
    tidyDataSet2 <- append(tidyDataSet2,outRow)
  }
}
tidyDataFrame2 <- data.frame(tidyDataSet2)
row.names(tidyDataFrame2) <- meanStdColNames
#transpose col/row
tidyDataFrame2 <- t(tidyDataFrame2)
#reconstruct activty and subject from row.names
c <- lapply(row.names(tidyDataFrame2), function(x) strsplit(x, ".", fixed=T))
subject <- lapply(c, function(x) x[[1]][3])
activity <- lapply(c, function(x) x[[1]][1])
tidyDataFrame2 <- cbind(activity, subject, tidyDataFrame2)

#writes out tidy data set #2
write.csv(tidyDataFrame2, file="tidyDataSet2.txt" , row.names = F)


