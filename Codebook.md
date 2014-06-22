#Codebook
##for run_analysis.R

`features`: Read from features.txt. Represent all the features provided. Use as header for X.
`activity_labels`: Read from activity_labels.txt. Use to replace all values in y to descriptive activity names.

`subject_test`: Read from subject_test.txt. Raw data. subject.
`x_test`: Read from X_test.txt. Raw data. Value of certain features.
`y_test`: Read from y_test.txt. Raw data. Activity.
`subject_train`: Read from subject_train.txt. Raw data. subject.
`x_train`: Read from X_train.txt. Raw data. Value of certain features.
`y_train`: Read from y_train.txt. aw data. Activity.

`subject`: Combined subject. 
`x`: Combined x.
`dataset`: mean and standard deviation measurements extracted from x.
`y`: Combined y. 
`activity`: descriptive activity names generated based on `activity_labels` and `y`.

`mergedTable`: Combined `subject` `activity` & `dataset`.
`tidyData`: Independent tidy data set with the average of each variable for each `activity` and each `subject`. 