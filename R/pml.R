
#
# pml_train <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"))
# pml_testing <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"))
#
# as the data already been saved to data/pml.RData
# no need to download them again
#
library(caret)
data(pml)


#
# split dataset into training and validation
# the pml_testing is for prediction and submission
#
trainIndex <- createDataPartition(pml_train$classe, p=.7, list=F)
train      <- pml_train[trainIndex, ]
validate   <- pml_train[-trainIndex, ]

#
# variable selection
# build KNN model
#
fit <- knn(train, validate, train$classe, k=5)
#
# x validation aka confusion matrix
#
prediction <- predict(fit, validation)
table(prediction, validation)

#
# other algo to try, svm, decision tree, random forest, naive bayes classifier
#

#
#
#