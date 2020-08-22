
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")


# Load activity labels + features
library(data.table)
activityLabels <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("classLabels", "activityName"))
features <- fread("UCI HAR Dataset/features.txt", col.names = c("index", "featureNames"))
View(features)
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
View(measurements)
measurements <- gsub('[()]', '', measurements)


# Load train datasets
train <- fread("UCI HAR Dataset/train/X_train.txt")#
View(train)
train<- train[, featuresWanted, with = FALSE]  #With =False uses the fraturesWanted vector as col numbers for
#subsetting instead of searching featuresWanted as a col name

data.table::setnames(train, colnames(train), measurements)

trainActivities <- fread("UCI HAR Dataset/train/Y_train.txt", col.names = c("Activity"))
trainSubjects <- fread( "UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)



# Load test datasets
test <- fread("UCI HAR Dataset/test/X_test.txt")
test<-test[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread("UCI HAR Dataset/test/Y_test.txt", col.names = c("Activity"))
testSubjects <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)


# merge datasets and add labels
combined <- rbind(train, test)

# Convert classLabels to activityName basically. More explicit. 
combined[["Activity"]] <- factor(combined[, Activity]
                                 , levels = activityLabels[["classLabels"]]
                                 , labels = activityLabels[["activityName"]])


combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- dcast(data = combined, SubjectNum + Activity ~ variable,  mean)

data.table::fwrite(x = combined, file = "tidyData.csv", quote = FALSE)
