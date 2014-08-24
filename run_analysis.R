## setwd to the directory which contains the UCI HAR Dataset folder

## These two packages are needed for melt and ddply
## install.packages("reshape2")
## install.packages("plyr")
library("reshape2")
library("plyr")

## Read in the relevant training files; add the information about activities and subjects
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "activity")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
train <- cbind(train_y,train_subject,train_x)

## Read in the relevant test files; combine the information 
## (completely analogeous to the training files)
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "activity")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
test <- cbind(test_y,test_subject,test_x)

## Combine the training and test sets
merged_data <- rbind(train,test)

## Use the variable names from features.txt as labels for the merged data
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
feature_vector <- as.vector(features$V2)
names(merged_data) <- c("activity","subject",feature_vector)

## Extract only the mean and standard deviation for each measurement (by name)
allmean <-  merged_data[ , grepl( "mean" , names(merged_data) ) ]  
allstd <-  merged_data[ , grepl( "std" , names(merged_data) ) ] 
activity <-  merged_data[ , grepl( "activity" , names(merged_data) ) ] 
subject <-  merged_data[ , grepl( "subject" , names(merged_data) ) ] 
extract <- cbind(activity, subject, allmean, allstd)

## Replace activity IDs by activity names
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
extract$activity <- gsub("1", "WALKING", extract$activity) 
extract$activity <- gsub("2", "WALKING_UPSTAIRS", extract$activity) 
extract$activity <- gsub("3", "WALKING_DOWNSTAIRS", extract$activity) 
extract$activity <- gsub("4", "SITTING", extract$activity) 
extract$activity <- gsub("5", "STANDING", extract$activity) 
extract$activity <- gsub("6", "LAYING", extract$activity) 

## Melt data and calculate the average by activity and subject
melted_data <- melt(extract, id.vars = c("activity", "subject"))
tidy_data <- ddply(melted_data, c("activity", "subject"), summarise, average = mean(value))

## Output to a text file
write.table(tidy_data,"tidy_data.txt", row.names =FALSE)
