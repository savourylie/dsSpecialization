# README for the Getting and Cleaning Data Course Project

## Synopsis
The purpose of this project is to preprocess the data collected from wearables/health bands and make "tidy" and easy for further analysis.

## Motivation

This is a coursework of the Data Science Specialization of Coursera.

## How to run the Application
The application is implemented with R. To run the application, simply execute `run_analysis.R` with a R console.

## Files
Below are the files used in this project. A more detailed explanation of the data will come in the later sections.

### Training Set Files
* X_train.txt - the training dataset
* y_train.txt - the label dataset for the training dataset
* subject_train.txt - the subject data set that identifies who carries out the experiment for the training dataset

### Test Set Files
* X_test.txt - the test dataset
* y_test.txt - the activity label dataset for the test dataset
* subject_test.txt - the subject data set that identifies who carries out the experiment for the test dataset

## What is Done in the Data Preprocessing
### Data Processing
As addressed earlier, in this project we are only concerned with certain features from the original dataset. Specifically what are done in the data processing is be listed below:

**1. Merging the training and the test sets to create one data set.**
**2. Extracting only the measurements on the mean and standard deviation for each measurement.**
**3. Using descriptive activity names to name the activities in the data set**
**4. Appropriately labelling the data set with descriptive variable names.**
**5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.**

For further details, see `codebook.md`.

## License The contents of this repository are covered under the MIT License:
The MIT License (MIT)

Copyright (c) [2016] [Calvin Ku]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

