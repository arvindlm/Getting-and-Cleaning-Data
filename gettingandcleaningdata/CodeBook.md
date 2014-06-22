This file describes the inclusion of variables and transformation of data done as part of the peer assesment course project of getting and cleaning data course 
in coursera

The run_analysis.R script performs the following steps to clean the data:
1)We read the training data(X_train.txt),test data(X_test.txt) and merge data sets using rbind , resulting in 10299*561 data frame called mergedData

2) Similarly subjects and activities of test and training set are merged.

3) For  extracting mean and standard deviation  we apply the grep function on a data frame(features) obtained through features.txt and get the indices of all labels with "mean" and "std" int them which this we get a subset of the merged data 

4)We read the activity_labels.txt file from the "./data"" folder and store the data in a variable called activity.

5)We then create a data frame(tidyData) by combining the mergedSubject, mergedLabel and mergedData by column to get a new cleaned 10299x68 data frame. The "subject" column contains integers that range from 1 to 30 and the "activity" column contains 6 activity names .

6)We generate a second independent tidy data set . There are a total of 180 combinations (30 subjects * 6 activities). For each combination, we calculate the mean of each measurement resulting in a clean data frame. 

7)We write the result to a file "tidy_data.txt"  in current working directory.
