# Getting and Cleaning Data Course Project -- README.md

The data set represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


### This repository includes the following files:

- 'README.md' : This file

- 'courseProject.description.md' : Description of course project and deliverables from Coursera pages.

- 'run_analysis.R' : R program to create tidy data sets from the original data 

- 'CodeBook.md' : Description of tidy data sets.

- 'features_info.txt': Shows information about the variables from original data set.

- 'tidyData.csv': CSV file containing data set modified to fit project goals.

- 'tidyData_summary.csv': CSV file containing second data set with average values.

### R program description
The program consists of 4 functions running the main steps followed by code which ties them all together, checking which parts have been done already. This is so that I didn't have to download the data file every time I modified the script, for example.

#### function get_rawData(dataDir,dataSet_rootDir) - read in original data
- Download data zip file, unzip and get rid of extraneous stuff

#### function tidyData(dataSet_rootDir) - create tidy data set from original data
##### returns tidy data set data frame
- Creates columnNames vector from "features.txt"
- Creates activityNames "activity_labels.txt"
- Creates lookup table for converting activity numbers to descriptive activity names
- Combines the subject, activity and measurement files from the training and test subdirectories
- Using the combined files:
  -   Read in subject column
  -   Read in activity code column and convert to activity names
  -   Read in measurement data, then select only those columns with mean() and std() in the names
- Convert column names to lower case and modify column names:
  - Get rid of special characters: remove "()" from end of function names, like tBodyAccMag mean() -> tbodyaccmag mean
  - change remaining "(", ")" and "," to "_" 
  - change order of mean|std and x|y|z and change "-" to "." , 
so "fBodyGyro-mean()-Y"" -> "fbodygyro_ mean_y" -> "fbodygyro_y.mean"
This is so that I could split up by measurement name and axis and function (although I won't)
- Finally read all data in. 
- Add subject column and activity_name column to dataset
- Group, sort and export tidy data frame to parent environment
- Write CSV file for tidy data set

#### function addColumns(myTidyData,activity_num2Name) - add subject and activity_name columns
##### Called by tidyData
##### returns tidy data set data frame with subject and activity columns added at front
-   Read in subject column
-   Read in activity code column and convert to activity names
- Add subject column and activity_name column to dataset

#### function tidyData_summary(groupedData,dataSet_rootDir) - make data set with averages
##### returns tidy data set summary
- Make second tidy data set containing just the averages for all measurements from the first
 data set, grouped by subject and activity
- The column names will be "average_" then the measurement name from the first data set
- create summary containing unique combinations of subject an activity as first two columns
- create empty list for new columns 
- For each measurement:
  - use summarize() to calculate mean for subject-activy_name group 
  - add it as a list to column list
- Add new column names to combined column list
- Add combined column list to summary (subject and activity columns) as data frame
- Write CSV file for tidy data set summary

### Main program
- call get_rawData() if necessary
- call tidyData() if necessary
- group myTidyData if necessary
- call tidyData_summary() if necessary

