Codebook for: Tidy_data.txt
=====================================================
Experimental Study Design:

The experiment used to collect the data in the clean dataset
Tidy_data.txt involved 30  participants in both a test and training
group performing 6 different exercises while wearing smartphones.
The accelerometer and gyroscope recorded the following variables.
=====================================================
Codebook:
In the tidy dataset all the variables are average observatons for a 
specific combination of each activity and feature.  When analyzing the 
data the variables were renamed as follows.

Time: Denoted with a t in the original data set. In the cleaned
up data set the t was replaced with Time to make it clearer

Frequency: denoted with a f in the orignal data. In the cleaned
up data set the f was replaced with time to make it clearer that 
the readings were filtered using a certain frequency

Accelerometer:(originally acc) Readings taken from internal accelerometer on phone

Gyroscope:(originally gyro) Readings taken from internal gyroscope on the phone.

Body: stands for body acceleration

Gravity: stands for acceleration due to gravity

Magnitude: gives the magnitude of the signals

STD: (originally std) stands for standard deviation measurements

Mean: (originally mean) stands for mean measurements

========================================================
Choices made in Manipulating Data:

1. Merges the training and the test sets to create one data set.
	- Completed using rbind to combine metadata
	- Cbind was used combine the different variables together
	- method was selected, because data was coming from different files.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	- grep is used to search for indicies where mean and standard deviation occur in features
	- the indicies are used to subset the data
	- Reason: quickest and easiest method without looping.
3. Uses descriptive activity names to name the activities in the data set
	- Activity names are extracted from metadata, so they do not need be named manually.
	- loops through possible names and corresponding numbers so it does not have to loop through
	  the dataset
	- when a match is found replaces with appropriate activity word.
4. Appropriately labels the data set with descriptive variable names. 
	- The names that were unclear are listed in the codebook section
	- gsub was used to replace unclear strings
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	- the average needed to be taken with groups formed by two different factors
	- to accomplish this we used the ddply function from the plier function
	- write.table was used to write the new clean dataset to tidy_data.txt