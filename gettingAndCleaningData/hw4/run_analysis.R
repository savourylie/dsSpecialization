# 1. Merge the training set and the test set.

# Read files into dataframes
Xtrain <- read.table(file = "X_train.txt", header = FALSE, sep = "")
Xtest <- read.table(file = "X_test.txt", header = FALSE, sep = "")
ytrain <- read.table(file = "y_train.txt", header = FALSE, sep = "")
ytest <- read.table(file = "y_test.txt", header = FALSE, sep = "")
subtrain <- read.table(file = "subject_train.txt", header = FALSE, sep = "")
subtest <- read.table(file = "subject_test.txt", header = FALSE, sep = "")

# Bind the datasets
train <- cbind(Xtrain, ytrain, subtrain)
test <- cbind(Xtest, ytest, subtest)

all <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Import features from file
features <- read.table(file = "features.txt", sep = " ")

# Get mean indices
mean_indices <- grep("mean", features$V2)

# Get std indices
std_indices <- grep("std", features$V2)

# Combine the two vectors
mean_std <- c(mean_indices, std_indices)

# Sort the new vector
mean_std <- sort(mean_std)

# Subset the dataset all
data_mean_std <- all[, c(mean_std, 562, 563)]

# 3. Uses descriptive activity names to name the activities in the data set
descrptive_names <- c(as.character(features[mean_std, "V2"]), "activity", "subject")

# 4. Appropriately labels the data set with descriptive variable names.
names(data_mean_std) <- descrptive_names

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
g_activity <- group_by(data_mean_std, activity)
g_act_sub <- group_by(g_activity, subject, add = TRUE)
summary_activity_sub <- summarise_each(g_act_sub, funs(mean))
