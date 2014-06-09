#
# Step 1 - download data to the working directory and unzip them
#
    url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url,"data project.zip")
    unzip("data project.zip")
#
# Step 2 - create test and train data set separately including 
# the mean and std variables, activity and subject identificator
#
    # Create data set for the test group
        #read the variables names file
        varnames<-read.table("UCI HAR Dataset/features.txt", quote = "")
        #read the test group data
        testgroupdata<-read.table("UCI HAR Dataset/test/X_test.txt", quote = "")
        #add names to the test group data
        names(testgroupdata)<-varnames$V2
        #keep only variables with mean() and std() at the end of the variable name
        #\\( is included because there are meanFreq variables that we want to omit
        a<-grep("mean\\(|std",varnames$V2)
        testgroupdata<-testgroupdata[,a]
        #read subject and activity identificator and add them to the test data
        testsubjectid<-read.table("UCI HAR Dataset/test/subject_test.txt")
        testgroupdata$subject<-testsubjectid$V1
        testactivityid<-read.table("UCI HAR Dataset/test/y_test.txt")
        testgroupdata$activity<-testactivityid$V1

    #
    # Create data set for the train group. (Do the same as for test group)
    #
        traingroupdata<-read.table("UCI HAR Dataset/train/X_train.txt", quote = "")
        #add variable names
        names(traingroupdata)<-varnames$V2
        #keep only columns containg "mean()" or "std()" in the name
        traingroupdata<-traingroupdata[,a]
        #read subject and activity identificator and add them to the data
        datatrainid<-read.table("UCI HAR Dataset/train/subject_train.txt")
        traingroupdata$subject<-datatrainid$V1
        trainactivityid<-read.table("UCI HAR Dataset/train/y_train.txt")
        traingroupdata$activity<-trainactivityid$V1
    #
    # merge test and train data sets
    #
    data1<-rbind(traingroupdata,testgroupdata)

#
# Step 3 - Use descriptive activity names to name the activities in the data set
#    
    #1 walking              2 walkingupstairs
    #3 walkingdownstairs	4 sitting
    #5 standing             6 laying
    data1$activity<-sub("1","walking",data1$activity)
    data1$activity<-sub("2","walkingupstairs",data1$activity)
    data1$activity<-sub("3","walkingdownstairs",data1$activity)
    data1$activity<-sub("4","sitting",data1$activity)
    data1$activity<-sub("5","standing",data1$activity)
    data1$activity<-sub("6","laying",data1$activity)

#
#Step 4 - Appropriately labels the data set with descriptive variable names.
#
    #Variables are already named using labels in "futures.txt"files. 
    #Remove all "()" and "-" from variable names
    names(data1)<-gsub("\\(\\)", "", names(data1))
    names(data1)<-gsub("\\-", "", names(data1))

#
#Step 5 - Creates a second, independent tidy data set with the average of each  
#variable for each activity and each subject.
#
    for (i in 1:66) {
        dat<- aggregate(data1[,i]~data1$subject +data1$activity,data1,mean)
        if (i==1) {
            data2<-dat
        } else {
            data2[,(i+2)]<-dat[,3]
        }
    }

    #data2 has now "subject" and "activity"in the first two columns; rearrange variable names
    varnames<-names(data1)
    varnames<-c(varnames[67],varnames[68],varnames[1:66])
    names(data2)<-varnames
  
#6 - Exporting data into a .txt file:
    write.table(data2, "tidydata.txt", row.names = F)
    