################################################################################
# Script:      run_analysis.R
# Author:      Hasef
# Created:     17.06.2015
# For Details: cf. https://github.com/Hasef/03GettingCleaningData_CourseProject
################################################################################

library(data.table)
library(dplyr)
library(plyr)

# First clean up all variables in Environment:
rm(list=ls())

# (1) Load the data sets representing a kind of "master data"
# - for the activities
# - for the features
# and assign meaningful variable names to them
# -------------------------------------------------
dtActivities <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(dtActivities, c("V1", "V2"), c("activity_id", "activity_name"))

dtFeatures   <- fread("./UCI HAR Dataset/features.txt", header=FALSE)
setnames(dtFeatures, c("V1", "V2"), c("feature_id", "feature_name"))

# (2) (a) load the 3 data sets comprising the TRAIN data
#         - subject_train -> subject_train
#         - X_train       -> X_train
#         - y_train       -> activity_train
# and (b) "column-bind" them in the column order "subject|activity|X"
# ------------------------------------------------------------------
# (a)
dtSubject_Train  <- fread("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
dtX_Train        <- read.table("./UCI HAR Dataset/train/X_train.txt",  header=FALSE)
dtActivity_Train <- fread("./UCI HAR Dataset/train/y_train.txt",       header=FALSE)
# (b)
dtX_Train        <- cbind(dtSubject_Train, dtActivity_Train, dtX_Train)

# (3) (a) load the 3 data sets comprising the TEST data
#         - subject_test -> subject_test
#         - X_test       -> X_test
#         - y_test       -> activity_test
# and (b) "column-bind" them in the column order "subject|activity|X"
# ------------------------------------------------------------------
# (a)
dtSubject_Test  <- fread("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
dtX_Test        <- read.table("./UCI HAR Dataset/test/X_test.txt",  header=FALSE)
dtActivity_Test <- fread("./UCI HAR Dataset/test/y_test.txt",       header=FALSE)
# (b)
dtX_Test        <- cbind(dtSubject_Test,  dtActivity_Test,  dtX_Test)

# (4) Merge the TRAIN and TEST data sets (dtX_Train and dtX_Test) into one dataset:
# ---------------------------------------------------------------------------------
dtX <- rbind(dtX_Train, dtX_Test)

# (5) assign meaningful variable names:
---------------------------------------
setnames(dtX,   1:2, c("subject_id", "activity_id"))
setnames(dtX, 3:563, dtFeatures[, feature_name])

# (6) use descriptiv activity names using the activity master data previously
#     stored in dtActivities (cf. Step 1).
#     For this use the join-function of pacakge plyr
dtX<-join(dtActivities, dtX, by="activity_id", match="all")

# (7) along with the subject_id and activity_name colums additionaly 
#     extract only the mean- and standard deviation-measurements
#     using the select-function of the dplyr package:
dtX <- select(dtX, subject_id, activity_name, contains("mean"), contains("std"))

# (8) Create the final independent tidy data set with the average of 
#     each variable for each activity and each subject.
#     Make the result being ordered ascendingly 1st w.r.t. subject_id, 2nd w.r.t. activity_name.
#     To this by using the chaining method (operator %>%) using group_by and summarise_each 
#     functions of dplyr package:
result <- dtX %>% 
        group_by(subject_id, activity_name) %>%
        summarise_each(funs(mean)) %>%
        arrange(subject_id, activity_name)

# (9) Since starting with column 3 all feature-based columns are containing
#     MEAN-values now each columnname will be prefixed with "MEANOF__" to
#     make this more clearly:
X <- names(result)   
Y <- X[3:length(X)]
Y <- sapply(Y, function(varname) paste("MEANOF__", varname, sep=""), USE.NAMES=FALSE)
setnames(result, 3:length(names(result)), Y)

# (10) Finally write the "result" data set as a txt file created with write.table() using row.name=FALSE
#     to disk:
write.table (result, file="result_coursproject_03_getting_and_cleaning_data.txt", row.names=FALSE)
