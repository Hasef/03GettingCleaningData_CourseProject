# README file explaining the repository structure

This readme refers to github repo [Hasef/03GettingCleaningData\_CourseProject][1]. 

This repo is my result of solving the Course Project of the "Getting and Cleaning Data" course.
The repo has the following structure:

* Repository contents
* Details about script *run\_analysis.R*

## Repository contents
The following files are contained:

* **CodeBook.md:**
A short documentation of the tidy data set and its variables provided by the file *result\_coursproject\_03\_getting\_and\_cleaning\_data.txt* (being part of the rep, too) 
which is the result of tidying the data originally collected from the accelerometers from the Samsung Galaxy S smartphone
having been provided by the Course Project via a downloadable zip-Archive *getdata\_projectfiles\_UCI HAR Dataset.zip* (itself being NOT contained within this repository).

* **README.md (this file):**

* **result\_coursproject\_03\_getting\_and\_cleaning\_data.txt:**
The tidy data set the generation of which has been the goal of the course project.

* **run\_analysis.R:**
The R-script doing all the data tidying to obtain the tidy data finally having been written into file *result\_coursproject\_03\_getting\_and\_cleaning\_data.txt*.
Following section of the README will explain this script in detail.


## Script *run\_analysis.R*
### Preconditions w.r.t. to the execution environment
To successfully execute script *run\_analysis.R* the following local directory structure has to exist.
Assume you currently are in the working directory of your RStudio project:

    $ ls -R
    run_analysis.R
    
    ./UCI HAR Dataset:
    features.txt
    activity_labels.txt
    
    ./UCI HAR Dataset/test:
    X_test.txt  
    subject_test.txt  
    y_test.txt
    
    ./UCI HAR Dataset/train:
    X_train.txt  
    subject_train.txt  
    y_train.txt
    
Furhter it is assumed that the R packages *data.table*, *dplyr* and *plyr* are installed on your R environment.
They will be loaded into the R session using the *library()* function.

If this requirements are met you can run the script, e.g. in RStudio, typing:

    source('run_analysis.R')



### The algorithmic steps

This section explains the rough algorithm of script **run\_analysis.R** developed
as a solution for the Course Project of the "Getting and Cleaning Data" course. The result of this script is
the txt-file **result\_coursproject\_03\_getting\_and\_cleaning\_data.txt** containing the required tidy data set.

The script *run\_analysis.R* implements the following steps:

 1. Load the - you could say - "lookup" or "master" data for activities and features into data tables 
    *dtActivities* and *dtFeatures* and assign meaningful variable names to those data sets 
    (column names used will be:  "activity\_id", "activity\_name", "feature\_id", "feature\_name").
    
 2. Load the 3 data sets comprising the "TRAIN" data (*dtSubject\_Train* represents the subjects of the observations,
 *dtActivity\_Train* represents the activities of the observerations, *dtX\_Train* represents the obersvations each
 one measured by the 561 features) *AND* combine them by column-binding into one single data table (reassigned to *dtX\_Train*).
 
 3. Analogeously load the 3 data sets comprising the "TEST" data, finally combined into *dtX\_Test*.
 
 4. Merge *dtX\_Train* (of step 2) and *dtX\_Test* (of step 3) into one single data set **dtX** by row-binding.
 
 5. Now assign meaningful variable names to the columns of *dtX*: The first two columns will be 
 named "subject\_id" and "activity\_id". Columns 3 to 356 will be named according to the feature names.
 
 6. Next a column called "activity\_name" with the descriptive activity names will be added to *dtX* by using the *join()* function of package *plyr*.
 
 7. Using the *select()* function of the *dplyr* package we finally preserve only the columns *subject\_id*,
    *activity\_name* and all the measurement columns representing mean and standard deviations.
    The result will be reassigned to *dtX*.
    
 8. Using the *dplyr* package chaining operator "%>%" we first group the table *dtX* by columns "subject\_id" and "activity\_name".
 Then we use the *summarise\_each()* function to get the mean for **each** mean/std-measurement-column of *dtX* w.r.t.each existing
 subject\_id/acitivity\_name combination. This data set again will be ordered by subject\_id, followed by activity\_name. Finally
 the data set will be assigned to variable **result**.
 
 9. Since starting with column 3 of *result* all feature-based columns are containing MEAN-values now each columnname 
 will be "improved" by prefixing it with string "MEANOF\_\_" to make the MEAN-characteristic of its column values more clearly:
 This returns the final, independent tidy data set, that we aimed for, and being stored in variable **result**.
  
 10.  Finally the resulting tidy data set stored in *result* will be written to disk using the *write.table()* function.
 The name of the resulting file containing the tidy data set is *result\_coursproject\_03\_getting\_and\_cleaning\_data.txt*. This file is contained in the repository, too!
 
[1]: https://github.com/Hasef/03GettingCleaningData_CourseProject
