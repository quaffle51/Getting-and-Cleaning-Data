# Getting and Cleaning Data
Repository for storing files for the Coursera course Getting and Cleaning Data
### The R script file: run_analysis.R
In order for this R script to work properly, the following files should reside in the same directory as the script file or in the sub-directories 'train' or 'test'.

1. activity_labels.txt
2. features.txt
3. train/subject_train.txt
4. train/X_train.txt
5. train/y_train.txt
6. test/subject_test.txt
7. test/X_test.txt
8. test/y_test.txt

Click the link  to download these files in zip format from the Coursera web site: [download link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ).

The script then reads these comma delimited files into memory. After successfully doing this the script gives a summary of the files read in, which is similar to the following.

Reading tables ... 

... summary of tables read: 

Source: local data frame [8 x 3]
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

The following R code then combines the test and training data and stores the column headings from the second column of the features file:
```
col_headings            <- t(as.character(features$V2))
x_train_test            <- rbind_list(X_train,X_test)
y_train_test            <- rbind_list(y_train,y_test)
subject_train_test      <- rbind_list(subject_train,subject_test)
df1                     <- tbl_df(cbind(subject_train_test, y_train_test, x_train_test))
```
Thus, the above completes the first task.  The following code implements the second task as outlined in the code comments. It will be noted here that I have chosen to select only columns which conatin "mean()" and "std()". After this stage we no longer
need the "df1" table so it is removed.
```
##      2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
regEx <- "mean\\(\\)|std\\(\\)"

requiredCols <- c(1,2, grep(regEx, features$V2)+2)
df2 <- df1[,requiredCols]
rm("df1")
```
Appropriate labels are now added to the data set in step 4.
```
##      4. Appropriately labels the data set with descriptive variable names. 
names(activity_labels) <- c("Activity_ID", "Activity")
df3 <- tbl_df(merge(x=df2,y=activity_labels, by.x="Activity_ID", by.y="Activity_ID",sort=FALSE))
rm("df2")
df4 <- select(df3,c(2,69,3:68))
names(df4) <- gsub("-","_",names(df4))      # remove minus sign from column headings
names(df4) <- gsub("\\(\\)","",names(df4))  # remove parentheses  from column headings
```


