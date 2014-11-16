

## You should create one R script called run_analysis.R that does the following. 
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
##      3. Uses descriptive activity names to name the activities in the data set
##      4. Appropriately labels the data set with descriptive variable names. 
##      5. From the data set in step 4, creates a second, independent tidy data 
##         set with the average of each variable for each activity and each subject.

####################################################################################
## See David's Project FAQ in the Forums/Course Project for useful clarifications ##
####################################################################################

library(dplyr)

##      1. Merges the training and the test sets to create one data set.

cat("Reading tables ...","\n\n")
## 'activity_labels.txt': Links the class labels with their activity name
activity_labels <- tbl_df(read.table("activity_labels.txt"))

## 'features.txt': List of all features
filename <- "features.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
features <- tbl_df(read.table(filename,header = FALSE, colClasses = classes, comment.char = "", nrows = 561))

## 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
filename <- "train/subject_train.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
subject_train <- tbl_df(read.table(filename,header = FALSE, colClasses = classes, comment.char = "", nrows = 7352))

## 'train/X_train.txt': Training set.
filename <- "train/X_train.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
X_train <- tbl_df(read.table(filename,header = FALSE, colClasses = classes, comment.char = "", nrows = 7352))

## 'train/y_train.txt': Training labels.
filename <- "train/y_train.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
y_train <- tbl_df(read.table(filename,header = FALSE, colClasses = classes, comment.char = "", nrows = 7352))

## 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
filename <- "test/subject_test.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
subject_test <- tbl_df(read.table(filename,header = FALSE, colClasses = classes, comment.char = "", nrows = 2947))

## 'test/X_test.txt': Test set.
filename <- "test/X_test.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
X_test <- tbl_df(read.table(filename, header = FALSE, colClasses = classes, comment.char = "", nrows = 2947))

## 'test/y_test.txt': Training labels.
filename <- "test/y_test.txt"
tab5rows <- read.table(filename, header = FALSE, nrows = 5)
classes <- sapply(tab5rows, class)
y_test <- tbl_df(read.table(filename, header = FALSE, colClasses = classes, comment.char = "", nrows = 2947))

###############################################################
## not part of the project, but summarise the tables read-in ##   
###############################################################

filename <- c( 
        "activity_labels",
        "features",
        "subject_train",
        "X_train",
        "y_train", 
        "subject_test",
        "x_test",
        "y_test"
)

num_rows <- c( 
        nrow(activity_labels),
        nrow(features),
        nrow(subject_train),
        nrow(X_train),
        nrow(y_train),
        nrow(subject_test),
        nrow(X_test),
        nrow(y_test)
)

num_cols <- c( 
        ncol(activity_labels),
        ncol(features),
        ncol(subject_train),
        ncol(X_train),
        ncol(y_train),
        ncol(subject_test),
        ncol(X_test),
        ncol(y_test)
)

sum_tbl <- tbl_df(data.frame(filename,num_rows,num_cols))
sum_tbl <- arrange(sum_tbl, desc(num_rows), desc(num_cols))

cat("... summary of tables read:","\n\n")
print(sum_tbl)

x_train_test            <- rbind_list(X_train,X_test)
y_train_test            <- rbind_list(y_train,y_test)
subject_train_test      <- rbind_list(subject_train,subject_test)
df1                     <- tbl_df(cbind(subject_train_test, y_train_test, x_train_test))
########################################################################################

##      2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
regEx <- "mean\\(\\)|std\\(\\)"

requiredCols <- c(1,2, grep(regEx, features$V2)+2)
df2 <- df1[,requiredCols]
rm("df1")
        

##      3. Uses descriptive activity names to name the activities in the data set

requiredFeatures <- features[grepl(regEx, features$V2),]
names(df2) <- colLabels <- c("Subject", "Activity_ID", as.character(requiredFeatures$V2))

##      4. Appropriately labels the data set with descriptive variable names. 
names(activity_labels) <- c("Activity_ID", "Activity")
df3 <- tbl_df(merge(x=df2,y=activity_labels, by.x="Activity_ID", by.y="Activity_ID",sort=FALSE))
rm("df2")
df4 <- select(df3,c(2,69,3:68))
names(df4) <- gsub("-","_",names(df4))      # remove minus sign from column headings
names(df4) <- gsub("\\(\\)","",names(df4))  # remove parentheses  from column headings

##      5. From the data set in step 4, creates a second, independent tidy data 
##         set with the average of each variable for each activity and each subject.
by_activity <- group_by(df4, Activity, Subject)
df5 <- summarise_each(by_activity, funs(mean))

cat("\nWriting table for submission: ...","\n\n")
filename <- "file_for_submission.txt"
write.table(df5,file = filename, row.names = FALSE)
cat("\"",list.files(pattern = filename), "\" written to disc.\n\n",sep="")
cat("... Finished.")

