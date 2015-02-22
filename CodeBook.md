# Getting And Cleaning Data: CodeBook
Getting-And-Cleaning-Data-Course-Project

1. The data was downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and it contains the following files:
  * 'features.txt': List of all features.
  * 'activity_labels.txt': List of class labels and their activity name.
  * 'train/X_train.txt': Training set.
  * 'train/y_train.txt': Training labels.
  * 'train/subject_train.txt': ID's of subjects in the training data
  * 'test/X_test.txt': Test set.
  * 'test/y_test.txt': Test labels.
  * 'test/subject_test.txt': ID's of subjects in the training data
2. If the package "reshape2" is not installed the script installs it in order to run.
3. The script reads all the files into data frames and adds the corresponding headers to each of them.
4. Merges all the train files into a data frame called "train_data" by using _cbind_.
5. Merges all the test files into a data frame called "test_data" by using _cbind_.
6. Merges the "train_data" and "test_data" data frames into a single data frame called "full_data" by using _rbind_.
7. From that data frame it selects only the mean and standard deviation variables(columns that contains the word "-mean" or "std") plus the "Subject_Id" and "Activity_Id" ones (by using regular expressions). It assigns the result to the same data frame (full_data).
8. Adds the "Activity_Name" to the "full_data" data frame by merging it with the "activities" data frame by "Activity_Id".
9. Melts the "full_data" data frame into a "melt_data" data frame with the following id_vars: Subject_Id", "Activity_Id", "Activity_Name" in order to produce a clean data frame that contains the average of each variable for each activity and each subject.
10. Creates a final clean data frame called "clean_data" that contains the  average of each variable for each activity and each subject by using _dcast_ with the "melt_data" data frame.
11. Writes the clean_data data frame into the local directory as "clean_dataset.txt" and displays the following message: _"The analysis ran successfully. A Clean data file called 'clean_dataset.txt' has been written into your working directory"_
12. Removes all the objects from memory.
