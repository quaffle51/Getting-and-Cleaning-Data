CodeBook: Getting and Cleaning Data Course Project 
==================================================
Outlined here are the steps necessary to clean and tidy the set of [data files:](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The R script **run_analysis.R** performs the necessary steps to combine the training and test data and to extract a tidy data set ready for submission to Coursera.

The following R package is required:
```
dplyr
```
The following scratch pad variables are created to try to speed-up the reading of files from disk.

```
filename # to hold the name of the data file to be read into memory
top5rows # stores the top five rows of the data file
classes  # stores the classes as determined from the top5rows variables.
```

The data read into memory from file are stored in the following variables, which correspond to the names of the files stored on disk.
```
features
subject_train
X_train
y_train
subject_test
X_test
y_test
``` 
After the data files have been read a summary of the data is printed to the console summarising the number of rows and colums associated with each of the files read in.

<table align="right">
    <tr>
        <td></td>
		<th>filename</th>
		<th>num_rows</th>
		<th>num_cols</th>
    </tr>
	<tr>
       <td>1</td>
		<td>X_train</td>
		<td>7352</td>
		<td>561</td>
    </tr>
	<tr>
       <td>2</td>
		<td>subject_train</td>
		<td>7352</td>
		<td>1</td>
    </tr>
	<tr>
       <td>3</td>
		<td>y_train</td>
		<td>7352</td>
		<td>1</td>
    </tr>
	<tr>
       <td>4</td>
		<td>x_test</td>
		<td>2947</td>
		<td>561</td>
    </tr>
	<tr>
       <td>5</td>
		<td> subject_test</td>
		<td>2947</td>
		<td>1</td>
    </tr>
	<tr>
       <td>6</td>
		<td>y_test</td>
		<td>2947</td>
		<td>1</td>
    </tr>
	<tr>
       <td>7</td>
		<td>features</td>
		<td>561</td>
		<td>2</td>
    </tr>
	<tr>
       <td>8</td>
		<td>activity_labels</td>
		<td>6</td>
		<td>2</td>
    </tr>
</table>

The test and data files are combined and stored in the following variables.
```
x_train_test
y_train_test 
subject_train_test 
```
These are then combined into a single data frame: `df1`.

The variable `regEx` stores a regular expression used with `grep` to extract columns from `df1` that contain "mean()" and "std()" in the column names. `requiredCols` contains the names of the columns matching the regular expression which are extracted into the data frame
`df2`.  The data frame `df3` is based on `df2`, but has an extra column created by merging `df2` with `activity_labels` to give descriptive names to the activities.  From `df3` the data frame `df4` is created by extracting columns 2, 69, and 3 to 68 from `df3`.

`by_activity` is a data frame created from `df4` which is grouped by `Activity`.

`df5` is a data frame created from `by_activity` that gives the grouped means for each column in `by_activity` which are grouped by `Activity`.

Finally, the data frame `df5` is written to disk with filename `file_for_submission.txt`.




