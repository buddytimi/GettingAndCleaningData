##create tidy data set 1

###load activity labels from activity_labels.txt
* extract activity code and name from the data frame

###load features labels from features.txt
* extract column mean() and std() numbers/names 


###load test data from "test/X_test.txt"
* remove non mean() and std() cols from the test data frame
* add descriptive column names
* load test data subject
* append subject column to the test data frame
* add descriptive name to the subject column



###load training data from "train/X_train.txt"
* remove non mean and std cols
* remove non mean() and std() cols from the train data frame
* add descriptive column names
* load train data subject
* extract and append subject column to the train data frame
* add descriptive name to the subject column


###merge test and train data frame
* create activity code and name column
* add descriptive name to the activity columns
* append the activity code and name the the merged data frame

###writes out tidy data set  1 to file tidyDataSet1.txt in csv format


##create tidy data set 2

###slice tidyDataSet 1 by activity and subject
* split tidyDatSet1 by activity
* for each activity in tidyDataSet1
*   split by subject
*   for each subject compute variable means
*      add descriptive name to the column
*      add row to tidyDataSet2
##add descriptive variable column to tidyDataSet2

###writes out tidy data set 1 to file tidyDataSet2.txt in csv format
