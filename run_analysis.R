#create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

####################   Program   ##################################
#Load data.
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#Merge data.
subject <- rbind(subject_test, subject_train)
colnames(subject) <- "subject"

#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
x <- rbind(x_test, x_train)
colnames(x) <- features[,2]
mean <- grep("mean()",colnames(x),fixed=TRUE)
std <- grep("std",colnames(x),fixed=TRUE)
dataset <- x[, sort(c(mean, std))]

#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
y <- rbind(y_test, y_train)
activity <- data.frame()
for(i in 1:nrow(y)){
        activity[i,1]<-activity_labels[y[i,1], 2]
}
colnames(activity) <- "activity"
mergedTable <- cbind(subject, activity, dataset)
mergedTable <- mergedTable[order(mergedTable$subject), ]

write.table(mergedTable, file="mergedTable.txt", row.names = FALSE)

#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidyData <- aggregate( mergedTable[,3] ~ subject+activity, data = mergedTable, FUN= "mean" )
for(i in 4:ncol(mergedTable)){
        tidyData[,i] <- aggregate( mergedTable[,i] ~ subject+activity, data = mergedTable, FUN= "mean" )[,3]
}
colnames(tidyData)[3:ncol(tidyData)] <- colnames(dataset)
write.table(tidyData, file = "average.txt", row.names = FALSE)