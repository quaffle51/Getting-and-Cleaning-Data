CodeBook: Getting and Cleaning Data Course Project 
==================================================
Outlined here are the steps necessary to clean and tidy the set of [data files:](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The R script run_analysis.R performs the necessary steps to combine the training and test data and to extract a tidy data for submission to Coursera.

The followin R package is required:
```
dplyr
```
The following scratch pad variables are created to try to speed up the reading of files from disk.

```
filename # to hold the name of the data file to be read into memory
tab5rows # stores the top five rows of the data file
classes  # stores the classes as determined from the top5rows variables.
```

The data read in from file are stored in the following variables.
```
features
subject_train
X_train
y_train
subject_test
X_test
y_test
``` 
