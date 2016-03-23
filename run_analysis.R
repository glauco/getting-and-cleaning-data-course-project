library(data.table)
library(dplyr)

getActivities <- function() {
    # Reads the kind of activities performed by the subjects of this experiment.
    # The information is read as a data.table object.
    # The data.table object will contain following columns:
    #   - activityID
    #   - activityName
    activities <- fread("data/activity_labels.txt",
                        sep = " ",
                        nrows = 6,
                        header = FALSE,
                        col.names = c("activityID", "activityName"))
    return(activities)
}


getTrainingData <- function(activities = getActivities) {
    # Reads experiment's training data.
    # The information is read as a data.table object.
    # The data.table object will contain the following columns:
    #   - subjectID
    #   - activityID
    #   - activityName
    #   - 561 unnamed observations
    getTrainingSubjects <- function() {
        # Reads subjects that were part of the training.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - subjectID
        trainingSubjects <- fread("data/train/subject_train.txt",
                                  sep = " ",
                                  nrows = 7352,
                                  header = FALSE,
                                  col.names = c("subjectID"))
        return(trainingSubjects)
    }

    getTrainingActivities <- function() {
        # Reads activities that were performed during the training.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - activityID
        trainingActivities <- fread("data/train/y_train.txt",
                                    sep = " ",
                                    nrows = 7352,
                                    header = FALSE,
                                    col.names = c("activityID"))
        return(trainingActivities)
    }

    trainingActivities <- getTrainingActivities()
    trainingSubjects <- getTrainingSubjects()

    trainingData <- fread("data/train/X_train.txt",
                          sep = " ",
                          nrows = 7352,
                          header = FALSE) %>%
                    mutate(activityID = trainingActivities$activityID) %>%
                    mutate(subjectID = trainingSubjects$subjectID) %>%
                    merge(activities, by = "activityID")

    return(trainingData)
}

getTestData <- function(activities = getActivities) {
    # Reads experiment's test data.
    # The information is read as a data.table object.
    # The data.table object will contain the following columns:
    #   - subjectID
    #   - activityID
    #   - activityName
    #   - 561 unnamed observations
    getTestSubjects <- function() {
        # Reads subjects that were part of the test.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - subjectID
        testSubjects <- fread("data/test/subject_test.txt",
                              sep = " ",
                              nrows = 2947,
                              header = FALSE,
                              col.names = c("subjectID"))
        return(testSubjects)
    }

    getTestActivities <- function() {
        # Reads activities that were performed during the test.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - activityID
        testActivities <- fread("data/test/y_test.txt",
                                sep = " ",
                                nrows = 2947,
                                header = FALSE,
                                col.names = c("activityID"))
        return(testActivities)
    }

    testActivities <- getTestActivities()
    testSubjects <- getTestSubjects()

    testData <- fread("data/test/X_test.txt",
                      sep = " ",
                      nrows = 2947,
                      header = FALSE) %>%
                mutate(activityID = testActivities$activityID) %>%
                mutate(subjectID = testSubjects$subjectID) %>%
                merge(activities, by = "activityID")

    return(testData)
}

consolidateData <- function(trainingData, testData) {
    # Merges the training and the test sets to create one data set.
    # The information is read as a data.table object.
    # The data.table object will contain the following columns:
    #   - subjectID
    #   - activityID
    #   - activityName
    #   - 561 unnamed observations
    consolidatedData <- merge(trainingData, testData,
                              by = names(trainingData),
                              all = TRUE)
    return(consolidatedData)
}

extractRelevantMeasurements <- function(consolidateData) {
    # Extracts only measurements related to mean and standard deviation.
    # The information is read as a data.table object.
    # The data.table object will contain the following columns:
    #   - subjectID
    #   - activityName
    #   - 87 observations related to mean and standard deviation
    getObservationNames <- function() {
        # Reads the kind of observations performed during this experiment.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - observationID
        #   - observationName
        observationNames <- fread("data/features.txt",
                                  sep = " ",
                                  nrows = 561,
                                  header = FALSE,
                                  col.names = c("observationID", "observationName"))

        # Since I already know that the experiment observations that matter
        #  are the ones related to mean value and standard deviation, I am already
        #  giving them meaningful names.
        observationNames$observationName <- gsub("-X",
                                                 "InXAxis",
                                                 observationNames$observationName)
        observationNames$observationName <- gsub("-Y",
                                                 "InYAxis",
                                                 observationNames$observationName)
        observationNames$observationName <- gsub("-Z",
                                                 "InZAxis",
                                                 observationNames$observationName)
        observationNames$observationName <- gsub("mean",
                                                 "MeanValue",
                                                 observationNames$observationName,
                                                 ignore.case = TRUE)
        observationNames$observationName <- gsub("std",
                                                 "StandardDeviation",
                                                 observationNames$observationName,
                                                 ignore.case = TRUE)
        observationNames$observationName <- gsub("-",
                                                 "",
                                                 observationNames$observationName)
        observationNames$observationName <- gsub("\\(\\)",
                                                 "",
                                                 observationNames$observationName)

        return(observationNames)
    }

    setMeaningfulColumnNames <- function(consolidatedData) {
        # Updates column names with the proper observation names.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - subjectID
        #   - activityID
        #   - activityName
        #   - 561 named observations
        observationNames <- getObservationNames()
        colnames(consolidatedData) <- c("activityID",
                                        observationNames$observationName,
                                        "subjectID",
                                        "activityName")
    }

    setMeaningfulColumnNames(consolidatedData)

    filterRelevantData <- function(consolidatedData) {
        # Filter only measurements related to mean and standard deviation.
        # The information is read as a data.table object.
        # The data.table object will contain the following columns:
        #   - subjectID
        #   - activityName
        #   - 87 observations related to mean and standard deviation
        filteredData <- select(consolidatedData,
                               matches("subjectID"),
                               matches("activityName"),
                               contains("MeanValue"),
                               contains("StandardDeviation"))
        return(filteredData)
    }

    return(filterRelevantData(consolidatedData))
}

summarizeMeasurements <- function(relevantMeasurements) {
    # Summarizes relevant measurements.
    # It groups data by activity and subject. Once grouped, it
    #  calculates the mean for each column.
    # The information is read as a data.table object.
    # The data.table object will contain the following columns:
    #   - subjectID
    #   - activityName
    #   - 87 summarized observations related to mean and standard deviation
    summarizedData <- relevantMeasurements %>%
                        group_by(activityName, subjectID) %>%
                        summarise_each(funs(mean))
    return(summarizedData)
}

saveTidyData <- function(summarizedData, destfile = "data/tidy.csv") {
    # Stores tidy dataset on disk.
    # By default, stores it at 'data/tidy.csv'
    write.csv(summarizedData, file = destfile)
}

activities <- getActivities()
trainingData <- getTrainingData(activities)
testData <- getTestData(activities)

consolidatedData <- consolidateData(trainingData, testData)
relevantMeasurements <- extractRelevantMeasurements(consolidatedData)
summarizedData <- summarizeMeasurements(relevantMeasurements)
saveTidyData(summarizedData)
