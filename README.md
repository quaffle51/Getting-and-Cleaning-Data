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


