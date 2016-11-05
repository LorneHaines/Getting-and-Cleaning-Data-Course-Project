####################################################################
# Filename: run_analysis.R
# Date: 11/03/2016
# Purpose:Reads in activity labels, features, and accelerometer
# and gyroscope data.  Combines training and test datasets into 
# 1 clean dataset with mean and standard deviation varialbes.
# Finds the average of each variable for activity and subject ID
# Outputs: Tidy_data.txt. The data is formatted, by combining training
# and test data, then keeping variable with mean or std.  The final 
# result averages these varialbes over Subject ID and activity
####################################################################

setwd("G:/Coursera/Course 3 Data Cleaning/Course_Proj_Cleaning_Dat/getdata_projectfiles_UCI HAR Dataset")
library(plyr)

# loading in metadata
names_features <- read.table("./UCI HAR Dataset/features.txt")
activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                    header = FALSE)

# reading in data from training subjects
subjectTrainId <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrainId <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)


# reading in data from test subjects
subjectTestId <- read.table("./UCI HAR Dataset/test/subject_test.txt", head = F)
activityTestId <- read.table("./UCI HAR Dataset/test/y_test.txt", head = F)
featuresTest_data <- read.table("./UCI HAR Dataset/test/X_test.txt")




### Merges the training and the test sets to create one data set.###
# combines data sets from training and tests subjects
subject <- rbind(subjectTrainId, subjectTestId)
activity <- rbind(activityTrainId, activityTestId)
features <- rbind(featuresTrain_data, featuresTest_data)

# names all data columns with the corresponding features
colnames(features) <- t(names_features[2])
# names categorical variables
colnames(subject) <- "Subject_Id"
colnames(activity) <- "Activity"

combined_dset <- cbind(subject, activity, features)




### Extracts only the measurements on the mean and standard deviation ###
# gives indicies of variables with mean or standard deviation
MeanSDevColumns <- grep(".*mean.*|.*std.*", names(combined_dset), ignore.case = TRUE)
# adds in indicies of subjects and activities
all_columns <- c(1, 2, MeanSDevColumns)

# Extrats mean and standard deviation data
combo_mean_sdev_dat<- combined_dset[all_columns]



### Use descriptive activity names to name the activities in the data set  ###
# vector of activity names
activities <- t(activity_Labels[2])

# replaces the number representing each activity with the name for the activity
for (i in 1:length(activities)) {
  combo_mean_sdev_dat$Activity[combo_mean_sdev_dat$Activity == i] <- activities[i]
}

### Apropriately relabels the dataset with descriptive variable names ###
names(combo_mean_sdev_dat) <- gsub("^t", "Time", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("^f", "Frequency", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("Acc", "Accelerometer", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("Gyro", "Gyroscope", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("Mag", "Magnitude", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("BodyBody", "Body", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("tBody", "TimeBody", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("std()", "STD", names(combo_mean_sdev_dat), ignore.case = T)
names(combo_mean_sdev_dat) <- gsub("mean()", "Mean", names(combo_mean_sdev_dat), ignore.case = T)
names(combo_mean_sdev_dat) <- gsub("freq()", "Frequency", names(combo_mean_sdev_dat), ignore.case = T)
names(combo_mean_sdev_dat) <- gsub("angle", "Angle", names(combo_mean_sdev_dat))
names(combo_mean_sdev_dat) <- gsub("gravity", "Gravity", names(combo_mean_sdev_dat))



### Creating Indepenedent Tidy Dataset with Average for each var & activity ###
combo_mean_sdev_dat$Subject_Id <- as.factor(combo_mean_sdev_dat$Subject_Id)

# splits data frame by variables specified, applies function then combines result into 1 data frame
tidy_data <- ddply(.data = combo_mean_sdev_dat, .variables = c("Subject_Id", "Activity"), .fun = numcolwise(mean))

# writing data to file
write.table(tidy_data, file = "Tidy_data.txt", row.names = FALSE)