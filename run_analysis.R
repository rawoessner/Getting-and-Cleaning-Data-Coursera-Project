library(dplyr)
#Scan X_test data and create a data frame
test_data <- scan('test/X_test.txt')
test_data <- matrix(test_data, ncol = 561, byrow = TRUE)
test_data <- as.data.frame(test_data)
test_data <- test_data[1:nrow(test_data)-1,] #remove last row of test data due to lack of activity label

#Scan X_train data and create a data frame
train_data <- scan('train/X_train.txt')
train_data <- matrix(train_data, ncol = 561, byrow = TRUE)
train_data <- as.data.frame(train_data)
train_data <- train_data[1:nrow(train_data)-1,] #remove last row of train data due to lack of activity label

#Create vector for column names
features <- read.csv('features.txt', header = FALSE, sep = " ")
colnames(test_data) <- features$V2
colnames(train_data) <- features$V2

#Merges the training and the test sets to create one data set.
total_data <- rbind(test_data, train_data)

#Create vector of test and train subjects
test_subject <- read.csv('test/subject_test.txt')
train_subject <- read.csv('train/subject_train.txt')
colnames(test_subject) <- 'X1'
subject <- rbind(test_subject, train_subject)
colnames(subject) <- 'subject'

#Combind train and test activity data
test_activity <- read.csv('test/y_test.txt')
train_activity <- read.csv('train/y_train.txt')
activity <- rbind(test_activity, train_activity)
colnames(activity) <- 'activity'

#Create a combined data frame with subject, activity and measurement data.
total_data <- cbind(subject, activity, total_data)

#Set activity column to factor to change level names and convert back to character type
total_data$activity <- factor(total_data$activity)
levels(total_data$activity) <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
total_data$activity <- as.character(total_data$activity)

#Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data <- total_data[,grep("subject|activity|mea|std", names(total_data), value=TRUE)]


#Group data on subject and activity and calculate mean for each activity and subject
grouped.df <- mean_std_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

#Write the grouped data frame to a text file
write.table(grouped.df,file = "grouped.df.txt", row.names = FALSE)
