#Setting Directory
## 1. Confirm the current directory
getwd()
## 2. Change the directory to the Quiz folder
setwd("C:/Users/1412053/Desktop/Quiz")

#Get the Data from URL
## 1. Download the file
DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(DataURL, destfile="./20Dataset.zip")
## 2. Unzip the file
unzip(zipfile="./20Dataset.zip")
## 3. Get the list of the files
pathrf <- file.path(./"UCI HAR Dataset")
files <-list.files(pathrf, recursive=TRUE)
files

# Propressing 
setwd("./UCI HAR Dataset")
## 1. Reading Features
features <- read.table("./features.txt")
features <-features[, c("V2")]
## 2. Reading Train Data and merge data 
trainsubj <- read.table("./train/subject_train.txt")
trainobs <-read.table("./train/X_train.txt")
trainact <- read.table("./train/y_train.txt")
traindata <- cbind(trainsubj, trainact, trainobs)
tail(traindata)
## 3. Reading Test Data
testsubj <- read.table("./test/subject_test.txt")
testobs <-read.table("./test/X_test.txt")
testact <- read.table("./test/y_test.txt")
testdata <- cbind(testsubj, testact, testobs)
tail(testdata)
## 4. Labeling of column name on Train and Test Dataset
features <-as.character(features)
names(traindata) <- c(c("subject", "activity"), features)
names(testdata) <- c(c("subject", "activity"), features)
## 5. Combine Test dataset and Train dataset. 
alldata <- rbind(traindata, testdata)
## 5. Reading Activity Label Data
actlabel <- read.table("./activity_labels.txt")
actlabel <- actlabel[, c("V2")]
## 6. convert of activity column from numeric factor value to descriptive factor value, which is actlabel processed at step 5. 
alldata$activity <- actlabel[alldata$activity]
alldata

# Extract only the measurements on the mean and standard deviation for each measurement
selectfeat <- grep("mean|std", features)
selectdata <-alldata[,c(1, 2, selectfeat+2)]
selectdata

# Appropriately labels the data set with descriptive variable names.
names(selectdata) <- gsub("^t", "time", names(selectdata))
names(selectdata) <- gsub("^f", "frequency", names(selectdata))
names(selectdata) <- gsub("[()]", "", names(selectdata))
names(selectdata) <- gsub("-", "_", names(selectdata))
names(selectdata) <- gsub("Acc", "Accelerometer", names(selectdata))
names(selectdata) <- gsub("Gyro", "Gyroscope", names(selectdata))
names(selectdata) <- gsub("Mag", "Magnitude", names(selectdata))
names(selectdata) <- gsub("BodyBody", "Body", names(selectdata))
str(selectdata)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

finaldata <- aggregate(selectdata[,c(-1, -2)], by = list(activity = selectdata$activity, subject = selectdata$subject),FUN = mean)
finaldata
write.table(finaldata, file="finaldata.txt", row.name=FALSE)

