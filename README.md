# Getting and Cleaning Data - Course Project

This repository contains the course project for [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning).

The analyzed dataset was [Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The dataset was downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and uncompressed to [data directory](https://github.com/glauco/getting-and-cleaning-data-course-project/tree/master/data).

## How does this works?

[run_analysis.R](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R) is the script responsible for tidying the dataset.
It is composed by several smaller functions, each one responsible for one thing:
- [getActivities](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L4,L16): Retrieves the kind of activities performed by the subjects of this experiment.
- [getTrainingData](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L19,L65): Retrieves experiment's training data. This includes the subjects and activities performed.
- [getTestData](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L67,L113): Retrieves experiment's test data. This includes the subjects and activities performed.
- [consolidateData](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L115-L127): Merges the training and test datasets.
- [extractRelevantMeasurements](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L129,L211): Extracts only the measurements related to mean and standard deviation.
- [summarizeMeasurements](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L213,L226): Summarizes relevant measurements. It groups data by activity and subject, and then calculates the mean for each column.
- [saveTidyData](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L228,L232): Stores tidy dataset on disk.

Once executed, the script [will invoke these functions](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/run_analysis.R#L234,L241) on the following order:
```R
activities <- getActivities()
trainingData <- getTrainingData(activities)
testData <- getTestData(activities)

consolidatedData <- consolidateData(trainingData, testData)
relevantMeasurements <- extractRelevantMeasurements(consolidatedData)
summarizedData <- summarizeMeasurements(relevantMeasurements)
saveTidyData(summarizedData)
```

## What do I need to run this?

First of all, only need to have R installed on your computer.

If you are running Mac OS X, you can easily install it using Homebrew:
```
brew update && brew install R
```

If you are running GNU/Linux Ubuntu, you can easily install it using apt:
```
sudo apt-get update && sudo apt-get install r-base
```

If you are using a different operating system and don't have R installed, please refer to [The Comprehensive R Archive Network](https://cran.r-project.org)

This project uses the following external dependencies:
- [`data.table`](https://cran.r-project.org/web/packages/data.table/index.html)
- [`dplyr`](https://cran.r-project.org/web/packages/dplyr/index.html) p

If you want, you could simply execute the [install_dependencies.R](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/install_dependencies.R) script
```
R --no-save < install_dependencies.R
```
This script will install the aforementioned dependencies for you.

## How do I run this?

Clone the project from GitHub:
```
git clone https://github.com/glauco/getting-and-cleaning-data-course-project.git
```
It might take a while, since there are a few huge text files on this repository.

Go to the repository:
```
cd getting-and-cleaning-data-course-project
```

Run the tidy script:
```
R --no-save < run_analysis.R
```

Once done, you will notice a new file (data/tidy.csv) inside the directory data. This is the processed tidy dataset.

If you are curious about the meaning of each one of the columns, go ahead and checkout the [Codebook](https://github.com/glauco/getting-and-cleaning-data-course-project/blob/master/Codebook.md) for this dataset.
