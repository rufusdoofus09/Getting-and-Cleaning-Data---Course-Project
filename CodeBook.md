# Getting and Cleaning Data Course Project -- CodeBook

The data set represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

from original data set README.txt:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "

####Notes: 
- Measurements are normalized and bounded within [-1,1].
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.



## Description of Variables  -- modified data set (tidyData.csv)
Data consists of a total of 10299 observations of 30 subjects performing 
each of 6 activities. There are no "NA" values.

#####For each observation:
- An identifier of the subject who carried out the experiment.
- The activity label. 
- A 66 measurement vector with mean and standard deviation of time and frequency domain variables. 


Name						|Type				|Values					|Description
----------------|-----------|---------------|-----------
subject         |Integer		|1-30				    |Subject number 
activity_name   |Factor			|walking        |Activity being performed.    
-							|					|walking_upstairs  | original data set used
-							|					|walking_downstairs| integer values or 1-6
-							|					|sitting           | These were modifed to
-							|					|standing          | be the activity name
-							|					|laying            	|	
tbodyacc_x.mean   |Double				|-1.0 - 1.0				| See features_info.txt for
tbodyacc_y.mean   |Double			|-1.0 - 1.0	 | explanation of all measurements.
tbodyacc_z.mean   |Double			|-1.0 - 1.0	 | Variable names have been modified 
tbodyacc_x.std    |Double			|-1.0 - 1.0	 | to be lower case and special 
tbodyacc_y.std    |Double			|-1.0 - 1.0	 | characters removed or modified.
tbodyacc_z.std    |Double			|-1.0 - 1.0	 | Only mean() and std() measurements
tgravityacc_x.mean  |Double			|-1.0 - 1.0	 | from original data are included.
tgravityacc_y.mean  |Double			|-1.0 - 1.0	 |
tgravityacc_z.mean  |Double			|-1.0 - 1.0	 |
tgravityacc_x.std   |Double			|-1.0 - 1.0	 |
tgravityacc_y.std   |Double			|-1.0 - 1.0	 |
tgravityacc_z.std   |Double			|-1.0 - 1.0	 |
tbodyaccjerk_x.mean |Double			|-1.0 - 1.0	 |
tbodyaccjerk_y.mean |Double			|-1.0 - 1.0	 |
tbodyaccjerk_z.mean |Double			|-1.0 - 1.0	 |
tbodyaccjerk_x.std  |Double			|-1.0 - 1.0	 |
tbodyaccjerk_y.std  |Double			|-1.0 - 1.0	 |
tbodyaccjerk_z.std  |Double			|-1.0 - 1.0	 |
tbodygyro_x.mean    |Double			|-1.0 - 1.0	 |
tbodygyro_y.mean    |Double			|-1.0 - 1.0	 |
tbodygyro_z.mean    |Double			|-1.0 - 1.0	 |
tbodygyro_x.std     |Double			|-1.0 - 1.0	 |
tbodygyro_y.std     |Double			|-1.0 - 1.0	 |
tbodygyro_z.std     |Double			|-1.0 - 1.0	 |
tbodygyrojerk_x.mean|Double			|-1.0 - 1.0	 |
tbodygyrojerk_y.mean|Double			|-1.0 - 1.0	 |
tbodygyrojerk_z.mean|Double			|-1.0 - 1.0	 |
tbodygyrojerk_x.std |Double			|-1.0 - 1.0	 |
tbodygyrojerk_y.std |Double			|-1.0 - 1.0	 |
tbodygyrojerk_z.std |Double			|-1.0 - 1.0	 |
tbodyaccmag.mean    |Double			|-1.0 - 1.0	 |
tbodyaccmag.std     |Double			|-1.0 - 1.0	 |
tgravityaccmag.mean |Double			|-1.0 - 1.0	 |
tgravityaccmag.std  |Double			|-1.0 - 1.0	 |
tbodyaccjerkmag.mean|Double			|-1.0 - 1.0	 |
tbodyaccjerkmag.std |Double			|-1.0 - 1.0	 |
tbodygyromag.mean   |Double			|-1.0 - 1.0	 |
tbodygyromag.std    |Double			|-1.0 - 1.0	 |
tbodygyrojerkmag.mean |Double			|-1.0 - 1.0	 |
tbodygyrojerkmag.std  |Double			|-1.0 - 1.0	 |
fbodyacc_x.mean   |Double			|-1.0 - 1.0	 |
fbodyacc_y.mean   |Double			|-1.0 - 1.0	 |
fbodyacc_z.mean   |Double			|-1.0 - 1.0	 |
fbodyacc_x.std    |Double			|-1.0 - 1.0	 |
fbodyacc_y.std    |Double			|-1.0 - 1.0	 |
fbodyacc_z.std    |Double			|-1.0 - 1.0	 |
fbodyaccjerk_x.mean |Double			|-1.0 - 1.0	 |
fbodyaccjerk_y.mean |Double			|-1.0 - 1.0	 |
fbodyaccjerk_z.mean |Double			|-1.0 - 1.0	 |
fbodyaccjerk_x.std  |Double			|-1.0 - 1.0	 |
fbodyaccjerk_y.std  |Double			|-1.0 - 1.0	 |
fbodyaccjerk_z.std  |Double			|-1.0 - 1.0	 |
fbodygyro_x.mean  |Double			|-1.0 - 1.0	 |
fbodygyro_y.mean  |Double			|-1.0 - 1.0	 |
fbodygyro_z.mean  |Double			|-1.0 - 1.0	 |
fbodygyro_x.std   |Double			|-1.0 - 1.0	 |
fbodygyro_y.std   |Double			|-1.0 - 1.0	 |
fbodygyro_z.std   |Double			|-1.0 - 1.0	 |
fbodyaccmag.mean  |Double			|-1.0 - 1.0	 |
fbodyaccmag.std   |Double			|-1.0 - 1.0	 |
fbodybodyaccjerkmag.mean  |Double			|-1.0 - 1.0	 |
fbodybodyaccjerkmag.std   |Double			|-1.0 - 1.0	 |
fbodybodygyromag.mean |Double			|-1.0 - 1.0	 |
fbodybodygyromag.std  |Double			|-1.0 - 1.0	 |
fbodybodygyrojerkmag.mean |Double			|-1.0 - 1.0	 |
fbodybodygyrojerkmag.std  |Double			|-1.0 - 1.0	 |

## Description of Variables -- summary data set (tidyData_summary.csv)
This data set contains the average value for each measurement grouped by subject and activity.

Name						|Type				|Values					|Description
----------------|-----------|---------------|-----------
subject         |Integer		|1-30				    |Subject number 
activity_name   |Factor			|as above        |Activity being performed    
average_tbodyacc_x.mean   |Double				|-1.0 - 1.0				| Average value of measurement
average_tbodyacc_y.mean   |Double			|-1.0 - 1.0	 | from above data set
average_tbodyacc_z.mean   |Double			|-1.0 - 1.0	 |Variable names are as above 
average_tbodyacc_x.std    |Double			|-1.0 - 1.0	 | prepended by "average_"
average_tbodyacc_y.std    |Double			|-1.0 - 1.0	 | 
average_tbodyacc_z.std    |Double			|-1.0 - 1.0	 | 
average_tgravityacc_x.mean  |Double			|-1.0 - 1.0	 | 
average_tgravityacc_y.mean  |Double			|-1.0 - 1.0	 |
average_tgravityacc_z.mean  |Double			|-1.0 - 1.0	 |
average_tgravityacc_x.std   |Double			|-1.0 - 1.0	 |
average_tgravityacc_y.std   |Double			|-1.0 - 1.0	 |
average_tgravityacc_z.std   |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_x.mean |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_y.mean |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_z.mean |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_x.std  |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_y.std  |Double			|-1.0 - 1.0	 |
average_tbodyaccjerk_z.std  |Double			|-1.0 - 1.0	 |
average_tbodygyro_x.mean    |Double			|-1.0 - 1.0	 |
average_tbodygyro_y.mean    |Double			|-1.0 - 1.0	 |
average_tbodygyro_z.mean    |Double			|-1.0 - 1.0	 |
average_tbodygyro_x.std     |Double			|-1.0 - 1.0	 |
average_tbodygyro_y.std     |Double			|-1.0 - 1.0	 |
average_tbodygyro_z.std     |Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_x.mean|Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_y.mean|Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_z.mean|Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_x.std |Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_y.std |Double			|-1.0 - 1.0	 |
average_tbodygyrojerk_z.std |Double			|-1.0 - 1.0	 |
average_tbodyaccmag.mean    |Double			|-1.0 - 1.0	 |
average_tbodyaccmag.std     |Double			|-1.0 - 1.0	 |
average_tgravityaccmag.mean |Double			|-1.0 - 1.0	 |
average_tgravityaccmag.std  |Double			|-1.0 - 1.0	 |
average_tbodyaccjerkmag.mean|Double			|-1.0 - 1.0	 |
average_tbodyaccjerkmag.std |Double			|-1.0 - 1.0	 |
average_tbodygyromag.mean   |Double			|-1.0 - 1.0	 |
average_tbodygyromag.std    |Double			|-1.0 - 1.0	 |
average_tbodygyrojerkmag.mean |Double			|-1.0 - 1.0	 |
average_tbodygyrojerkmag.std  |Double			|-1.0 - 1.0	 |
average_fbodyacc_x.mean   |Double			|-1.0 - 1.0	 |
average_fbodyacc_y.mean   |Double			|-1.0 - 1.0	 |
average_fbodyacc_z.mean   |Double			|-1.0 - 1.0	 |
average_fbodyacc_x.std    |Double			|-1.0 - 1.0	 |
average_fbodyacc_y.std    |Double			|-1.0 - 1.0	 |
average_fbodyacc_z.std    |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_x.mean |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_y.mean |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_z.mean |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_x.std  |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_y.std  |Double			|-1.0 - 1.0	 |
average_fbodyaccjerk_z.std  |Double			|-1.0 - 1.0	 |
average_fbodygyro_x.mean  |Double			|-1.0 - 1.0	 |
average_fbodygyro_y.mean  |Double			|-1.0 - 1.0	 |
average_fbodygyro_z.mean  |Double			|-1.0 - 1.0	 |
average_fbodygyro_x.std   |Double			|-1.0 - 1.0	 |
average_fbodygyro_y.std   |Double			|-1.0 - 1.0	 |
average_fbodygyro_z.std   |Double			|-1.0 - 1.0	 |
average_fbodyaccmag.mean  |Double			|-1.0 - 1.0	 |
average_fbodyaccmag.std   |Double			|-1.0 - 1.0	 |
average_fbodybodyaccjerkmag.mean  |Double			|-1.0 - 1.0	 |
average_fbodybodyaccjerkmag.std   |Double			|-1.0 - 1.0	 |
average_fbodybodygyromag.mean |Double			|-1.0 - 1.0	 |
average_fbodybodygyromag.std  |Double			|-1.0 - 1.0	 |
average_fbodybodygyrojerkmag.mean |Double			|-1.0 - 1.0	 |
average_fbodybodygyrojerkmag.std  |Double			|-1.0 - 1.0	 |
