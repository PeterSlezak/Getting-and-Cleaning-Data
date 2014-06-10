This project is for peer assessments of Getting and Cleaning Data

Source zip file for the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 
Original description of the data and experiment: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Script run_analysis.R does the following:

 - The script downloads and unzips the source file to the working directory. (Providing that you already have "UCI HAR Dataset" folder containing the source data in the working directory then you just comment the first three lines of code out.)
 - The subject, X, and y files are loaded for both the test and train group separately. Headers (for the X files) are from the features.txt file and are applied to both the test and train datasets.
 - The Headers are used to extract only the variables with mean() and std() in the header string using a regex in order not to include meanFreq().
 - The test and train data sets are merged into one.
 - The descriptive activity names are used for the activities
 - X variables headers are modified by omitting metacharacters i.e. "(", ")", "-"
 - An aggregation is performed on all columns of the data frame, grouping by subject and activity. This yields 180 rows (30 subjects * 6 activities) and 68 variables (1st column for the subject id, 2nd for the activity and 66 columns for the futures containing mean() or std() in the name (1+1+66 = 68 columns).

The script produces "tidydata.txt" file in the current working directory.
The command source("run_analysis.R") will run the script, assuming the script is in your working directory. Finally read.table("tidydata.txt", header=TRUE) command will read the tidy data file.