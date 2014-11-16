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

The script then reads these comma delimited files into memory. After successfully doing this the script gives a summary of the files read in, which is similar to the following.

Reading tables ... 

... summary of tables read: 

Source: local data frame [8 x 3]

| |        filename| num_rows| num_cols|
|1|         X_train|     7352|      561|
|2|   subject_train|     7352|        1|
|3|         y_train|     7352|        1|
|4|          x_test|     2947|      561|
|5|    subject_test|     2947|        1|
|6|          y_test|     2947|        1|
|7|        features|      561|        2|
|8| activity_labels|        6|        2| 


