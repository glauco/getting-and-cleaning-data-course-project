# Codebook

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals `tAccIn[XYZ]Axis` and `tGyroIn[XYZ]Axis`. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`tBodyAccIn[XYZ]Axis` and `tGravityAccIn[XYZ]Axis`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`tBodyAccJerkIn[XYZ]Axis` and `tBodyGyroJerkIn[XYZ]Axis`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `fBodyAccIn[XYZ]Axis`, `fBodyAccJerkIn[XYZ]Axis`, `fBodyGyroIn[XYZ]Axis`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'In[XYZ]Axis' is used to denote 3-axial signals in the X, Y and Z directions.

- `tBodyAccIn[XYZ]Axis`
- `tGravityAccIn[XYZ]Axis`
- `tBodyAccJerkIn[XYZ]Axis`
- `tBodyGyroIn[XYZ]Axis`
- `tBodyGyroJerkIn[XYZ]Axis`
- `tBodyAccMag`
- `tGravityAccMag`
- `tBodyAccJerkMag`
- `tBodyGyroMag`
- `tBodyGyroJerkMag`
- `fBodyAccIn[XYZ]Axis`
- `fBodyAccJerkIn[XYZ]Axis`
- `fBodyGyroIn[XYZ]Axis`
- `fBodyAccMag`
- `fBodyAccJerkMag`
- `fBodyGyroMag`
- `fBodyGyroJerkMag`

The set of variables that were estimated from these signals are: 

- `MeanValue`: Mean value
- `StandardDeviation`: Standard deviation
- `MeanValueFreq`: Weighted average of the frequency components to obtain a mean frequency
- `angle()`: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the `angle()` variable:

- `gravityMean`
- `tBodyAccMean`
- `tBodyAccJerkMean`
- `tBodyGyroMean`
- `tBodyGyroJerkMean`