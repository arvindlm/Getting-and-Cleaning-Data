#  Merges the training and the test sets to create one data set.
trainData <- read.table("train/X_train.txt")
testData <- read.table("test/X_test.txt")
trainLabel <- read.table("train/y_train.txt")
testLabel <- read.table("test/y_test.txt") 
trainSubject <- read.table("train/subject_train.txt") 
testSubject <- read.table("test/subject_test.txt")
mergedData <- rbind(trainData, testData)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
ft <- read.table("features.txt")
features <- ft[,2]
stdMean <- grep("mean|std", features)
mergedData <- mergedData[, stdMean]
names(mergedData) <- ft[stdMean, 2]  



# Uses descriptive activity names to name the activities in the data set
mergedLabel <- rbind(trainLabel, testLabel)
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
activityLabel <- activity[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activityLabel
names(mergedLabel) <- "activity"


#  Appropriately labels the data set with descriptive activity names.
mergedSubject <- rbind(trainSubject, testSubject)
names(mergedSubject) <- "subject"






# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

tidyData <- cbind(mergedSubject, mergedLabel, mergedData)
aLen <- dim(activity)[1] 
sLen <- length(table(mergedSubject))
cLen <- dim(tidyData)[2]
result <- matrix(NA, nrow=sLen*aLen, ncol=cLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(tidyData)
x <- 1
for(i in 1:sLen) {
    for(j in 1:aLen) {
        result[x, 1] <- sort(unique(mergedSubject)[, 1])[i]
        result[x, 2] <- activity[j, 2]
        result[x, 3:cLen] <- colMeans(tidyData[i == tidyData$subject&activity[j, 2] == tidyData$activity, 3:cLen])
        x <- x + 1
    }
}
write.table(result, "tidy_data.txt") 