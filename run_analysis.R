# R code for Getting and Cleaning Data course project
# Class ending 24 Dec 2017 ... Merry Christmas to those who celebrate it!
library(tidyr)
library(readr)
library(dplyr)
library(rstudioapi)
library(rlang)
library(assertthat)
PROJECT_DIR <- getActiveProject()

dataDir <- file.path(PROJECT_DIR,"../data")
dataSet_rootDir <- file.path(dataDir,"UCI HAR Dataset")
dataSet_allDir <- "./all"

# Download data zip file, unzip and get rid of extraneous stuff
get_rawData <- function(dataDir,dataSet_rootDir)
{
  # If this doesn't exist we have not even unzipped file
  if (!file.exists(dataSet_rootDir))
  {
    if (!file.exists(dataDir))
      dir.create(dataDir);
    zipFile <- "UCI_HAR_Dataset.zip"
    destfile <- file.path(dataDir,zipFile)
    # IF this doesn't exist we have not downloaded the file
    if (!file.exists(destfile))
    {
      dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(dataURL,destfile=destfile)
    }
    unzip(destfile,exdir=dataDir)
  }
  # Get rid of MAC data directory
  dataSet_MACdir <- file.path(dataDir,"__MACOSX")
  if (file.exists(dataSet_MACdir)) unlink(dataSet_MACdir,recursive = T)
}

# Function to create the tidy data set from the raw data
# Creates columnNames vector from "features.txt"
# Creates activityNames "activity_labels.txt"
# Creates lookup table for converting activty numbers to descriptive activity names
# Combines the subject, activity and measurement files from the training and test subdirectories
# Using the combined files:
#   Read in subject column
#   Read in activity code column and convert to activity names
#   Read in measurement data, then select only those columns with mean() and std() in the names
tidyData <- function (dataSet_rootDir) 
{
  setwd(dataSet_rootDir)
  columnName_file="features.txt"
  # Export columnNames so that it's available to rest of program
  assign("columnNames",read_lines(columnName_file),envir = .GlobalEnv)
  activityName_file="activity_labels.txt"
  # Export activityNames so that it's available to rest of program
  assign("activityNames",read_lines(activityName_file),envir = .GlobalEnv)
  # make combined test set from training and test data and put in directory "all"
  dataSet_allDir <- "./all"
  if (!file.exists(dataSet_allDir))
  {
    dir.create(dataSet_allDir);
    farray=c("subject","X","y")
    f1<-file.path("./train",paste0(farray,"_train.txt"))
    f2<-file.path("./test",paste0(farray,"_test.txt"))
    f3<-file.path(dataSet_allDir,paste0(farray,".txt"))
    file.copy(f1, f3, overwrite =T)
    file.append(f3,f2)
  }
  # Make matrix as a lookup table to convert activity number to name 
  activity_num2Name<-matrix(unlist(strsplit(tolower(activityNames)," ")),ncol=2,byrow=T)
  # Make matrix for column names also, except don't need column number
  column_num2Name <- matrix(unlist(strsplit(columnNames," ")),ncol=2,byrow=T)

  # Inices into all column names for the ones we are interested in
  # Looking *only* for columns with "mean()" and "std()" in them
  mean_std_column_indices <- grep("(mean[(][)]|std[(][)])",columnNames)

  stripped_columnNames <- tolower(column_num2Name[,2])
  # make valid column names (no (),- allowed)
  # remove "()" from end of function names, like tbodyaccmag mean() -> tbodyaccmag mean
  # change remaining "(", ")" and "," to "_" 
  pretty_columnNames<-gsub("[(][)]","",stripped_columnNames)
  pretty_columnNames<-gsub("[-(),]","_",pretty_columnNames)
  # Now for the ones we care about, change order of mean|std and x|y|z and 
  # change "-" to "." , like "fbodygyro mean-y -> fbodygyro mean.y" 
  # attach xyz to the measurement name so we have "fbodygyro mean-y" -> "fbodygyro_y.mean"
  # This is so that we could split up by measurement name and function (although we won't)
  # We will not split by orientation (xyz)
  pretty_columnNames<-gsub("_(mean|std)_([xyz])","_\\2_\\1",pretty_columnNames)
  pretty_columnNames<-gsub("_(mean|std)","\\.\\1",pretty_columnNames)
  # Export tidy_columnNames so that it's available to rest of program
  assign("tidy_columnNames",pretty_columnNames[as.array(mean_std_column_indices)])




  # Finally read all data in. I read with fixed length fields since using sep=" " 
  # gave me extra empty columns I had to remove
  setwd(dataSet_allDir)
  fieldlengths<-rep(as.numeric(16), times=length(columnNames))
  alldata<-read.fwf("X.txt",widths=fieldlengths,header=F,sep="",col.names=pretty_columnNames)
  # Select just those columns with mean and std values using index vector from aboce
  myTidyData<-select(alldata,mean_std_column_indices)
  # If I screwed pretty_columnNames up I can always do 
  # names(myTidyData) <- prettier_columnNames[as.array(mean_std_column_indices)]
  
  # Get rid of humongous dataSet
  rm(alldata)

  
  # Add subject column and activity_name column to dataset
  myTidyData <- addColumns(myTidyData,activity_num2Name)
  

  # Export tidy data frame to parent environment
  assign("myTidyData",myTidyData)
  # Write CSV file for tidy data set
  write.csv(myTidyData,"tidyData.csv",row.names = F)
  return(myTidyData)
}

# Function to add subject and activity_name columns to dataset
# Called by tidyData
addColumns <- function (myTidyData,activity_num2Name) 
{
  print("myTidyData before adding subject and activity_name columns")
  head(myTidyData) %>% print

  subjects<-read.csv("subject.txt",header=F)
  names(subjects)<-"subject"
  activities<-read.csv("Y.txt",header=F)
  names(activities)<-"activity_index"

  activities %>% mutate(activity_name=activity_num2Name[activity_index,2]) -> activities
  myTidyData<-bind_cols(subjects,select(activities,activity_name),myTidyData)
  print("myTidyData after adding subject and activity_name columns")
  head(myTidyData) %>% print
  
  # Look at column names, activity names and counts of measurements for sanity check 
  print("Table of measurements by subject and activity")
  table(myTidyData$subject,myTidyData$activity_name) %>% print
  
  return(myTidyData)
}



# make small version of myTidyData for testing
# Get first n rows then modify subjects and activities to add some variation
tryTable_2 <- function(myTidyData,activity_num2Name,num_samples=20)
{
  small_tidyData<-myTidyData[1:num_samples,1:8]
  random_activities<-sample.int(2,num_samples,replace = T)
  random_subjects<-sample.int(3,num_samples,replace = T)
  small_tidyData %>% mutate(subject=random_subjects,activity_name=activity_num2Name[random_activities,2]) -> small_tidyData
  small_tidyData_tbl <- tbl_df(small_myTidyData)
  small_tidyData_tbl %>% group_by(subject,activity_name) -> small_grouped_tidyData
  small_tidy_columnNames<-names(small_tidyData_tbl)[3:length(names(small_tidyData_tbl))]
  return(small_grouped_tidyData)
}


# Make second tidy data set containing just the averages for all measurements from the first
# data set, grouped by subject and activity
# The column names will be "average_" then the measurement name from the first data set
tidyData_summary <- function(groupedData,dataSet_rootDir)
{
  columnNames<-names(groupedData)[3:length(names(groupedData))]
  num_cols <- length(columnNames)
  newcolumnNames<-paste0("average_",columnNames)
  
  # This is just the unique combinations of subject an activity as first two columns
  summary <- summarize(groupedData)
  mean_col_list <- list()
  # For each measurement, use summarize() to calculate mean for subject-activy_name group 
  # and add it as a list to mean_col_list
  for (i in columnNames[1:num_cols])
  {
    e<-as.symbol(i)
    t <- summarize(groupedData, mean(!!e))
    print(paste("summary with mean ",i))
    print(t)
    # Just to make sure that the rows are in the same order - otherwise would spend more cycles
    # on merge
    assert_that(are_equal(t[1:2], summary[1:2]))
    mean_col_list <- c(mean_col_list,t[3])
  }
  # Add new column names to combined columns
  names(mean_col_list) <- newcolumnNames
  # Add new columns to subject and activity columns
  summary <- bind_cols(summary,mean_col_list)
  
  dataSet_allDir <- "./all"
  setwd(dataSet_rootDir)
  setwd(dataSet_allDir)
  write.csv(summary,"tidyData_summary.csv",row.names = F)

  return(summary)
}


tidyCSV <-   file.path(dataSet_rootDir,dataSet_allDir,"tidyData.csv")
if (!exists("myTidyData"))
{
  if (!file.exists(tidyCSV))
  {
    myTidyData <- tidyData(dataSet_rootDir)
  } else
  {
    myTidyData<-read.csv(tidyCSV,header=T)
  }
}

if (!exists("grouped_tidyData"))
{
  tidyData_tbl <- tbl_df(myTidyData)
  tidyData_tbl %>% group_by(subject,activity_name) -> grouped_tidyData
}

tidy_summaryCSV <-   file.path(dataSet_rootDir,dataSet_allDir,"tidyData_sumary.csv")
if (!exists("myTidyData_summary"))
{
  if (!file.exists(tidy_summaryCSV))
  {
    myTidyData_summary <- tidyData_summary(grouped_tidyData,dataSet_rootDir)
  } else
  {
    myTidyData_summary<-read.csv(tidy_summaryCSV,header=T)
  }
}

