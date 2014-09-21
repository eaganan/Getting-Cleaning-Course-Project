#Set working directory in Samsung data

#Step 1:Merges the training and the test sets

#X_train.txt: Training set
X_train<-read.table("train/X_train.txt")
dim(X_train)
#y_train.txt: Training labels, Its range is from 1 to 6
y_train<-read.table("train/y_train.txt")
dim(y_train)
table(y_train)
#subject_train.txt: Each row identifies the subject who performed the activity
#for each window sample. Its range is from 1 to 30.
subject_train<-read.table("train/subject_train.txt")
dim(subject_train)
table(subject_train)

#X_test.txt: Test set
X_test<-read.table("test/X_test.txt")
dim(X_test)
#y_test.txt: Test labels.
y_test<-read.table("test/y_test.txt")
dim(y_test)
table(y_test)
#The same as subject_train
subject_test<-read.table("test/subject_test.txt")
dim(subject_test)
table(subject_test)

train_set<-cbind(subject_train,y_train,X_train)
test_set<-cbind(subject_test,y_test,X_test)
complete_set<-rbind(train_set,test_set)
dim(complete_set)
class(complete_set)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

##Put colnames
#First read feature names
features<-read.table("features.txt")
dim(features)
names(complete_set)<-c("subject","activity_number",as.character(features[,2]))

#Columns with mean() and std() names
select_columns<-grep("mean\\(\\)|std\\(\\)", names(complete_set),value=F)
complete_set2<-complete_set[,c(1,2,select_columns)]
str(complete_set2)

#Step 3: Uses descriptive activity names to name the activities in the data set

##Put activity labes
#First read activity labes
activity_labels<-read.table("activity_labels.txt",stringsAsFactors=F)
dim(activity_labels)
activity_labels
names(activity_labels)<-c("activity_number","activity_name")
table(complete_set$activity_number)

#join labels with data set
complete_set2<-merge(complete_set2,activity_labels,
by.x="activity_number",by.y="activity_number",all.x=T,sort=F)
#Check we don't have incomplete or duplicated cases
table(is.na(complete_set))
dim(complete_set)
table(is.na(complete_set2))
dim(complete_set2)

#rearrange column positions
complete_set2<-subset(complete_set2,select=c(subject,activity_number,
activity_name,3:68))

#Step4:Appropriately labels the data set with descriptive variable names
new_names<-names(complete_set2)
new_names<-gsub("^t","time_", new_names)
new_names<-gsub("^f","frequency_", new_names)
new_names<-gsub("Acc","_accelerometer_", new_names)
new_names<-gsub("Gyro","_gyroscope_", new_names)
new_names<-gsub("-|\\(\\)-","_", new_names)
new_names<-gsub("\\(\\)","", new_names)
new_names<-gsub("__","_", new_names)
new_names
names(complete_set2)<-new_names

#Step5:Appropriately labels the data set with descriptive variable names
average_dataSet<-aggregate(.~activity_name+subject,data=complete_set2[,-2],mean)
write.table(average_dataSet,"../average_dataSet.txt",row.names=F)