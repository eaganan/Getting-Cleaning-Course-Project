Getting-Cleaning-Course-Project
===============================

This repository contains submission of getting and cleaning data course project

First you set the working directory to the Samsung dataset
`setwd("/UCI HAR Dataset")`

### Step 1:Merges the training and the test sets

Read X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt with
`read.table()`

Merge every dataset with 
`cbind()` and then with `rbind()`

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

Read features.txt where feature names are, and then with regular expression identify
the columns names with mean() and std(). In this case, use `grep()` so we get column indices with this characteristic.
Use indices to select columns

### Step 3: Uses descriptive activity names to name the activities in the data set

Read activity_labels.txt where you can find activity names, then use 
`merge(,sort=F)` for join both dataset by column named activity_number 

### Step4:Appropriately labels the data set with descriptive variable names
Use gsub to rename columns:
Changes
* t by time
* f by frequency_
* Acc by _accelerometer_
* Gyro by _gyroscope_
* () or - by _

### Step5:Appropriately labels the data set with descriptive variable names
Use `aggregate()` to obtain column means by every combination of activity_name and subject

Finally, use `write.table()` to write the result

