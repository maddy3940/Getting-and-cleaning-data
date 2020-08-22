# Getting-and-cleaning-data

This repo is an assignment implementation from the course- Getting and Cleaning Data offered by John Hopkins University in Coursera

A dataset is given and the goal is to output a tidy data set.

The dataset is based on the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
The data set and its description can be found on [UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Information about the variables, data and transformations used in the project can be found in the codebook.

## The goals of the tidy data set as mentioned in the problem statement were:
1. Merge the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The R script for the analysis can be found in run_analysis.R

## Implementation details
1) The package data.table was used to create the tidy data.
2) After downloading the data and unziping it, the features labels were extracted from features.txt. It contains the column names that we are going to use further to assign column names to the tidy data set.
3) According to the problem we only need mean and standard deviation columns for each measurement in the train and test data. So, we filter out feature vector created above with rows containing only mean and standard deviation in their names by using grep command. Then we subset the required rows from the feature label vector. 
4) We subset the train and test dataset with the feature vector from above.
5) We assign new column names to these subsets of train and test set.
6) We extract the train_activity, test_activity, train_Subjects and test_subjects labels and use cbind to attach it with the data set from previous step.
7) Then we use rbind to join the train and test set.
8) Then melt and dcast function is used to create a tidy data set with the average of each variable for each activity and each subject.

