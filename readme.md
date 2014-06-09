This project is for peer assessments of Getting and Cleaning Data

Source zip file for the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the data and experiment: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Script: 	run_analysis.R
The script does the following:
 - The script downloads and unzips source file to the working directory. (If you alread have "UCI HAR Dataset" folder containing source data in working directory 
   than just comment first three lines of code out.)
 - The subject, X, and y files are loaded for both test and train group separately. Header (for X files) are from the features.txt file and applied to both test and train datasets.
 - The Headers are used to extract only variables with mean() and std() in the header string uaing a regex in order to not include meanFreq().
 - test and train data sets are merged into one. 
 - descriptive activity names are added for the activities
 - X variables headers are modified by omitting metacharacters i.e. "(", ")", "-"  
 - An aggregation is performed on all columns of the data frame, grouping by subject and activity. This yielded an 180 rows (30 subjects * 6 activities) and 
   the 68 variables (1st column for the subject id, 2nd for the activity and 66 columns for the futures containg mean() or std() in the name (1+1+66 = 68 columns).
 - script produses "tidydata.txt" file in the current working directory


The command source("run_analysis.R") will run the script, assuming the scrip is in your working directory.
Finally read.table("tidydata.txt", header=TRUE) command will read the tidy data file.