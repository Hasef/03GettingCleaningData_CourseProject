# 03GettingCleaningData_CourseProject
Repository created for the course project of data science course "Getting and Cleaning Data"
##Overview
The script *run_analysis.R* follows the following ideas:

 1. Load the lookup or master data for activities and features into data tables 
    *dtActivities* and *dtFeatures* and assign meaningful variable names to those data sets 
    (names used will be:  "activity_id", "activity_name", "feature_id", "feature_name").
    
 2. Load the 3 data sets comprising the "TRAIN" data (dtSubject_Train represents the subjects of the observations,
 dtActivity_Train represents the activities of the observerations, dtX_Train represents the obersvations each
 one measured by the 561 features) *AND* combine them by column-binding into one single data table (reassigned to dtX_Train).
 
 3. Analogeously load the 3 data sets comprising the "TEST" data, finally combined into dtX_Test.
 
 4. Combine dtX_Train and dtX_Test into one single data set dtX by row-binding.
 
 5. Now assign meaningful variable names to the columns of dtX: The first two columns will be 
 named "subject_id" and "activity_id". Columns 3 to 356 will be named according to the feature names.
 
 6. Next a column with the activity names will be added to dtX by using the join function of package plyr.
 
 7. Using the select() function of the dplyr function we finally preserve only the columns subject_id,
    activity_name and all the measurement columns representing mean and standard deviations.
    The result will be reassigned to dtX.
    
 8. Using the dplyr package chaining operator "%>%" we first group the table dtX by columns subject_id and activity_name.
 Then we use summarise_each to get the mean of each mean/std-measurement-column of dtX w.r.t.for each existing
 subject_id/acitivity_name combination.
 This is the final, independent tidy data set, that we aimed for. It is assigend to result.
  
 9.  Finally the resulting tidy data set will be stored to disk usind write.table() function.
 The filename is *result_coursproject_03_getting_and_cleaning_data.txt* being contained in the repository, too!
 
 
 