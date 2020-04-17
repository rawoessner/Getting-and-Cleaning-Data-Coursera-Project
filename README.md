#Getting-and-Cleaning-Data-Coursera-Project
====================================================================================
run_analysis.R script on Human Activity Recognition Using Smartphones Dataset
====================================================================================

The dplyr packackge is used for this analysis.

Initally, the test data and train data text files were scanned into the variables 'test_data' and 'train_data' respectively.  
Next, a matrix for each data set was filled with the text data that was scanned in, by row, with 561 columns (the column numbers equaled the number of variables).  
These matrices were transformed to data frames for ease of manipulation.

The 'features.txt' file was then read into a data frame and used to set the column names of the test_data and train_data data frames.  
The two data_frames were then  row combined into a master 'total_data' data frame.

Next, the 'subject_test.txt' and 'subjet_train.txt' files were read into a data frame and row combined to create a single 'subject' 
vector of identifiers of the subject who carried out the experiment. The same process was done for 'y_test.txt' and 'y_train.txt' to obtain 
an 'activity' vector of activity labels.  These two vectors were then column combined to the 'total_data' data frame. The 'activity' vector 
was converted to a factor vector and the numerical levels (1-6) where changed to strings with their descriptive 
names (i.e., WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

A new, smaller data frame was then created (mean_std_data) using the grep() function to pull only columns 
whose names included the characters 'subject', 'activity', 'mean' and 'std'. 
Column names were updated to more descriptive names.  
The data frame was then regrouped using the group_by() function in the dplyr package for grouping data by 
subject first, then activity level.  The summarise_all() function was then used to take the mean of each 
data point, grouped by suject and activity.  

Lastly, the write.table() function was used to store the output of the final grouped.df data frame. 

