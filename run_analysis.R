##' You should create one R script called run_analysis.R that does the following.
##' 1) Merges the training and the test sets to create one data set.
##' 2) Extracts only the measurements on the mean and standard deviation for each measurement.
##' 3) Uses descriptive activity names to name the activities in the data set
##' 4) Appropriately labels the data set with descriptive variable names.
##' 5) From the data set in step 4, creates a second, independent tidy data set with 
##'        the average of each variable for each activity and each subject.

library(dplyr)

##' Note: after loading the data I check the structure of the data to give me a better view of the
##' data.
##' And the numbers in the comments refers to the assignment numbers above.

##' As seen in the assignment, the data for the project can be found in the link above.  
##' The file will be downloaded and unzipped in directory "./Ass4" (Assignment Week 4). 
##' After unzipping the file, the downloaded datafile will be removed since it will not be used anymore.  
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Dataset.zip", quiet = TRUE, mode = "wb", method = "curl")
unzip("./Dataset.zip", exdir = "./Ass4")
file.remove("./Dataset.zip")

##' Returns the directories of *all* files (sub-directory files included) in the vector 'files'.
pathfiles <- file.path("./Ass4", "UCI HAR Dataset")
files <- list.files(pathfiles, recursive = TRUE)

##' Read all features and activity labels
features <- read.table(file.path(pathfiles, "features.txt"))
activitylables <- read.table(file.path(pathfiles, "activity_labels.txt"))

# The order of the rowbinding is kept consistence throughout the script to keep the correct data.
# That means train files comes for test files in the code.

# The following code merges the training and the test sets to create one data set for the 'X-files'.
# In the code below you will see 'X_train and than X_test' merged.
#       (1. Merges the training and the test sets to create one data set)  
# After merging the training and test sets of 'X', the variables will be named after the features 
# that were found in the code above. 
#       (4. Appropriately labels the data set with descriptive variable names). 
X_train <- read.table(file.path(pathfiles, "train", "X_train.txt"))
X_test <- read.table(file.path(pathfiles, "test", "X_test.txt"))
X_merge <- bind_rows(X_train, X_test)
names(X_merge) <- features[,2]

# After naming the variables it is easy to extract the measurements on the mean 
# and standard deviation is for each measurement
#       (2. Extracts only the measurements on the mean and standard deviation for each measurement; 
extract <- grepl("mean|std", names(X_merge))
X_merge <- X_merge[,extract]

# The following code merges the training and the test sets to create one data set for the 'y-files'.
# In the code below you will see 'y_train and than y_test' merged.
#       (1. Merges the training and the test sets to create one data set)  
y_train <- read.table(file.path(pathfiles, "train", "y_train.txt"))
y_test <- read.table(file.path(pathfiles, "test", "y_test.txt"))
y_merge <- bind_rows(y_train, y_test)

# After merging the training and test sets of 'y', the activitylables will be combined with y_merge
# with the left_join function. 
# (3. Uses descriptive activity names to name the activities in the data set)
# And the variables will be renamed to "Activity_ID" and "Activity_label"
#       (4. Appropriately labels the data set with descriptive variable names). 
y_merge <- left_join(y_merge, activitylables, by = "V1")
names(y_merge) <- c("Activity_ID", "Activity_label")

# After merging the training and test sets of 'subject', the variables will be renamed to "subject_ID"
#       (4. Appropriately labels the data set with descriptive variable names). 
subject_train <- read.table(file.path(pathfiles, "train", "subject_train.txt"))
subject_test <- read.table(file.path(pathfiles, "test", "subject_test.txt"))
subject_merge <- bind_rows(subject_train, subject_test)
names(subject_merge) <- "subject_ID"

##' bind these 3 datasets together and arrange the data according subject_ID and than Activity_ID
##' and than remove the Activity_ID column. This is to ensure the Activity_label is arranged
##' accordingly. Now this data set is ready for analysis.
data_wide <- bind_cols(subject_merge, y_merge, X_merge) %>% arrange(
                                        subject_ID, Activity_ID) %>% select(-Activity_ID)

##' group the data by subject_ID and than Activity_label and calculate for each variable the average
##' (5. From the data set in step 4, creates a second, independent tidy data set with 
##'        the average of each variable for each activity and each subject.) 
tidydata <- group_by(data_wide, subject_ID, Activity_label) %>% summarise_each(funs(mean))

##' Save the tidy data file to a txt file in the directory. 
write.table(tidydata, file = "./Ass4/tidydata.txt", row.names = FALSE)

