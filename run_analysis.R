library(dplyr)
#Read X_test data and create a data frame
test_data <- read.table('test/X_test.txt')

#Read X_train data and create a data frame
train_data <- read.table('train/X_train.txt')

#Create vector for column names
features <- read.table('features.txt', col.names = c('number', 'variables'))
colnames(test_data) <- features$variables
colnames(train_data) <- features$variables

#Merges the training and the test sets to create one data set.
total_data <- rbind(test_data, train_data)

#Create vector of test and train subjects
test_subject <- read.table('test/subject_test.txt', col.names= 'subject')
train_subject <- read.table('train/subject_train.txt', col.names = 'subject')
subject <- rbind(test_subject, train_subject)

#Combind train and test activity data
test_activity <- read.table('test/y_test.txt', col.names = 'activity')
train_activity <- read.table('train/y_train.txt', col.names = 'activity')
activity <- rbind(test_activity, train_activity)

#Create a combined data frame with subject, activity and measurement data.
total_data <- cbind(subject, activity, total_data)

#Set activity column to factor to change level names and convert back to character type
total_data$activity <- factor(total_data$activity)
levels(total_data$activity) <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
total_data$activity <- as.character(total_data$activity)

#Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data <- total_data[,grep("subject|activity|mean|std", names(total_data), value=TRUE)]

#Update Column names with descriptive variable names
names(mean_std_data) <- gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequence", names(mean_std_data))
names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))

#Group data on subject and activity and calculate mean for each activity and subject
grouped.df <- mean_std_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

#Write the grouped data frame to a text file
write.table(grouped.df,file = "grouped.df.txt", row.names = FALSE)
