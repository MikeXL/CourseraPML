
#
# pml_train <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"))
# pml_testing <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"))
#
# as the data already been saved to data/pml.RData
# no need to download them again
#
data(pml)

library(caret)

#
# split dataset into training and validation
# the pml_testing is for prediction and submission
#
trainIndex <- createDataPartition(pml_train$classe, p=.7, list=F)
train <- pml_train[trainIndex, ]
validate <- pml_train[-trainIndex, ]

#
#
#
#