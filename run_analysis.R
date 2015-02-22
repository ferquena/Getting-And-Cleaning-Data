
#####################################################################################################################
# Loads required library. In case is not installed it installs it.
#####################################################################################################################
if (!("reshape2" %in% rownames(installed.packages())) ) {install.packages('reshape2')}        
library(reshape2)
#####################################################################################################################        
#1) Merges the training and the test sets to create one data set.
#####################################################################################################################
#reads features and activities data
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names=c("Feature_Id", "Feature_Name"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names=c("Activity_Id", "Activity_Name"))

#reads train data and generates train_data data.frame
subject_train = read.table ("./data/UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "Subject_Id"
y_train = read.table ("./data/UCI HAR Dataset/train/y_train.txt")
names(y_train) = "Activity_Id"      
X_train = read.table ("./data/UCI HAR Dataset/train/X_train.txt")
names(X_train) = features$Feature_Name

train_data = cbind(subject_train, y_train, X_train)

#reads test data and generates test_data data.frame
subject_test = read.table ("./data/UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "Subject_Id"
y_test = read.table ("./data/UCI HAR Dataset/test/y_test.txt")
names(y_test) = "Activity_Id"        
X_test = read.table ("./data/UCI HAR Dataset/test/X_test.txt")
names(X_test) = features$Feature_Name        
test_data = cbind(subject_test, y_test, X_test)
        
## merge train and test data
full_data = rbind(train_data, test_data)

#####################################################################################################################        
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#####################################################################################################################
std_col_index = grep("std",names(full_data),ignore.case=TRUE)
std_col_names = names(full_data)[std_col_index]
mean_col_index = grep("mean",names(full_data),ignore.case=TRUE)
mean_col_names = names(full_data)[mean_col_index]
full_data =full_data[,c("Subject_Id","Activity_Id",mean_col_names,std_col_names)]
        
#####################################################################################################################        
# 3)Uses descriptive activity names to name the activities in the data set
#####################################################################################################################
full_data = merge(activities, full_data, by.x='Activity_Id', by.y='Activity_Id', all=TRUE)
        
#####################################################################################################################		
# 4)Appropriately labels the data set with descriptive variable names. 
# 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#####################################################################################################################
melt_data = melt(full_data, id=c("Subject_Id","Activity_Id","Activity_Name"))
clean_data = dcast(melt_data,Subject_Id + Activity_Id + Activity_Name ~ variable,mean) 
        
write.table(clean_data,"./clean_dataset.txt", row.name=FALSE)
print("The analysis ran successfully. A Clean data file called 'clean_dataset.txt' has been written into your working directory")
rm(list=ls())