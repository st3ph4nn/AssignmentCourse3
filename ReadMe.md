Data analysis of Human Activity Recognition Using Smartphones Dataset.  
Full description is available at the site where the data was obtainted
can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Contents
--------

-   ReadMe - This file in different formats (html, pdf, md and rmd)  
-   run\_analysis.R - R script that does the following:  
    *1. Merges the training and test sets to create one data set;*  
    *2. Extracts only the measurements on the mean and standard
    deviation for each measurement;*  
    *3. Uses descriptive activity names to name the activities in the
    data set;*  
    *4. Appropriately labels the data set with descriptive variable
    names;*  
    *5. From the data set in step 4, creates a second, independent tidy
    data set with the average of each variable for each activity and
    each subject.*
-   tidydata.txt - datafile outputted by run\_analysis.R
-   codebook - description of the variables, data and any
    transformations or work that is performed to clean up the data
    (html, pdf, md and rmd)

### Required R Packages

library(dplyr)

### Additional Notes

Data set that is needed will be downloaded through the R script
(run\_analysis.R).  
Data transformation is explained in the script itself and *not* in the
codebook.  
More info about the data can be found in the codebook.
