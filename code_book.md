#Course Project Code Book
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The attached R script (CleaningdataProject.R) performs the following to clean up the data:
Merges the following training and test sets:
- X_train.txt with X_test.txt, resulting in  XTT,10299x561 data frame
- subject_train.txt with test/subject_test.txt, the result of which is ST,a 10299x1 data frame
- y_train.txt with y_test.txt, the result of which is YTT,  a 10299x1 data  frame

Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. The result is a new  XTT, 10299x66 data frame, as  out of 561 attributes exactly 66 are measurements on the mean and sd.

Reads activity_labels.txt and applies descriptive activity names: WALKING,WALKINGUPATAIRS,WALKINGDOWNSTAIRS,SITTING,STANDING,LAYING

The script also appropriately labels the data set with descriptive names (XTT data frame)
Example: tBodyAcc-mean() 	becomes TBODYACC-MEAN-X
	tBodyAcc-std()   becomes TBODYACC-STD-X

Merges XTT,ST and YTT into the single data set – tidydata



At the end, the script create a new tidy  data set (tidydata1) with the average of each 
measurement for each activity and each subject.


