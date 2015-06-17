# DATA DICTIONARY w.r.t. file *result\_coursproject\_03\_getting\_and\_cleaning\_data.txt*


subject\_id

* max Data Length: 2

* 0..30: Id of a subject (person) who took part in the original experiment w.r.t. which this data set provides tidied and aggregated data.



activity\_name

* Enumeration with following elements: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING

* The descriptive name of an acitivity. Each row of the data set is a (unique) combination of subject\_id and activity\_name and contains mean-aggregated 
measurments of various features w.r.t. *its* (subject\_id, activity\_name) combination.



tBodyAcc-mean()-X .. fBodyBodyGyroJerkMag-std()

* numeric values between -1 and +1 

* Each one represents the mean w.r.t. the (subject\_id, activity\_name) combination of the row 
for a mean- or standard deviation-feature of the original data set collected from the accelerometers from the Samsung Galaxy S smartphone
having been provided by the Course Project via a downloadable zip-Archive *getdata\_projectfiles\_UCI HAR Dataset.zip*.




NOTE: This code book relates to [Hasef/03GettingCleaningData\_CourseProject][1] repository.

[1]: https://github.com/Hasef/03GettingCleaningData_CourseProject

