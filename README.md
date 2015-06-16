# The repository README file
It explains the repository created for the course project of data science course "Getting and Cleaning Data"
##Overview
The script *run_analysis.R* implements the following steps:

 1. Load the - you could say - lookup or master data for activities and features into data tables 
    *dtActivities* and *dtFeatures* and assign meaningful variable names to those data sets 
    (names used will be:  "activity_id", "activity_name", "feature_id", "feature_name").
    
 2. Load the 3 data sets comprising the "TRAIN" data (*dtSubject_Train* represents the subjects of the observations,
 *dtActivity_Train* represents the activities of the observerations, *dtX_Train* represents the obersvations each
 one measured by the 561 features) *AND* combine them by column-binding into one single data table (reassigned to *dtX_Train*).
 
 3. Analogeously load the 3 data sets comprising the "TEST" data, finally combined into *dtX_Test*.
 
 4. Combine *dtX_Train* (of step 2) and *dtX_Test* (of step 3) into one single data set **dtX** by row-binding.
 
 5. Now assign meaningful variable names to the columns of *dtX*: The first two columns will be 
 named "subject_id" and "activity_id". Columns 3 to 356 will be named according to the feature names.
 
 6. Next a column called "activity_name" with the descriptive activity names will be added to *dtX* by using the *join()* function of package *plyr*.
 
 7. Using the *select()* function of the *dplyr* package we finally preserve only the columns *subject_id*,
    *activity_name* and all the measurement columns representing mean and standard deviations.
    The result will be reassigned to *dtX*.
    
 8. Using the *dplyr* package chaining operator "%>%" we first group the table *dtX* by columns "subject_id" and "activity_name".
 Then we use the *summarise_each()* function to get the mean for **each** mean/std-measurement-column of *dtX* w.r.t.each existing
 subject_id/acitivity_name combination.
 This returns the final, independent tidy data set, that we aimed for. It is assigend to variable **result**.
  
 9.  Finally the resulting tidy data set stored in *result* will be written to disk using the *write.table()* function.
 The name of the resulting file containing the tidy data set is *result_coursproject_03_getting_and_cleaning_data.txt*. This file is contained in the repository, too!
 
 