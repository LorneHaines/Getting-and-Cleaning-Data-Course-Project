Read Me fo R getting and Cleaning Data Project

Data Set Source: Human Activity Recognition Using Smartphones Dataset
===================================================
Goal of Analysis:
The goal of this analysis is to find average readings for the standard deviation and mean observations
made by smartphone accelerometers and gyroscopes, then to write the results to a tidy dataset.

===================================================
Experimental Design & Data Format:
The original untidy data is taken from an experiment using 30 people and their smartphones.
While wearing the phones the people performed six activities including walking, walking up
stairs, walking downstairs, sitting, standing, and laying.  The phones captured 3 directional
readings using an internal accelerometer and gyroscope while the subjects performed the activities.

The original data was contained in two different folders.  One folder contained the data from
training subjects.  The other contained data from testing subjects.  Accompanying each dataset, were
separate text files that contained the metadata.

==================================================
The Analysis:

Step1: Loading in metadata
The names of variables corresponding to the accelerometer and gyroscope readings, are loaded in from
features.txt in the UCI HAR Dataset folder.  The activity labels corresponding to each index are loaded
from activity_labels.txt.  Accelerometer and gyroscope readings along with their metadata are read from 
test and training data.

Step 2: Stitching together the data.
The subject Id's, activity indexes, and feature variable names are stitched together. using r bind.
This will allow the training and test datasets to be combined with labels.

Step 3: Adding labels to the combined dataset.
Colnames is used to add labels to all the numerical variables, and the categorical variables
Subject_Id and activity.

Step 4: Extracting Indices of Mean and Standard Deviation Variables & Subsetting the Dataset with them.
Grep is used to get the indicies of all variables with the abbreviation for mean and standard deviation.
Then the indices are used to subset the data to include just mean and standard deviation as requested.

Step 5: Changes observations in variable Activities to descriptive strings.

Step 6: Relabel Variable Names
Uses gsub to search for undescriptive strings in the column titles and replaces them.
This was done so variable names are more readable and easily understandable.

Step 7: Finding average for each variable by Subject ID and Activity
In order to sort the data easily, subject Id needs to be made into a categorical variable.  Once this
is done ddply can be used to apply the mean to each column and each category.

Step 8: Write data to file
The write command is used to write the new tidy dataset to Tidy_data.txt.
