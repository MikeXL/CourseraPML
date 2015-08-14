Coursera Practical Machine Learning Writeup
===

##Introduction


```
pml_train <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"))
pml_testing <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"))
trainIndex <- createDataPartition(pml_train$classe, p=.7, list=F)
train <- pml_train[trainIndex, ]
validate <- pml_train[-trainIndex, ]
```


##Variable selection and Model building

```
features <- c(roll_belt, pitch_belt, yaw_belt,
                  accel_belt_x, accel_belt_y, accel_belt_z,
                  magnet_belt_x, magnet_belt_y, magnet_belt_z,
                  accel_arm_x, accel_arm_y, accel_arm_z,
                  magnet_arm_x, magnet_arm_y, magnet_arm_z,
                  accel_dumbbell_x, accel_dumbbell_y, accel_dumbbell_z,
                  magnet_dumbbell_x, magnet_dumbbell_y, magnet_dumbbell_z,
                  accel_forearm_x, accel_forearm_y, accel_forearm_z,
                  magnet_forearm_x, magnet_forearm_y, magnet_forearm_z
)

fit <- knn(train[features], validate[features], train$classe, data=train)
```


##Validation
in sample error = .329
out sample error = .341

```
table(predict(fit, validate)$predict, validate$classe)
```

##Considerations

also explored naive bayes classifier, decision tree and random forest. the simplest solution above give good enough accuracy.

```
fit <- randomForest(classe~features, data=train)
```

##Analysis 
[Compiled HTML file][5]


🖖



[1]: http://mikexl.github.io/machine-learning/coursera-pml.html
[2]: http://groupware.les.inf.puc-rio.br/har
[3]: https://class.coursera.org/predmachlearn-031/human_grading/view/courses/975200/assessments/4/submissions/36
[4]: https://github.com/MikeXL/CourseraPML 
[5]: http://mikexl.github.io/CourseraPML/html "HTML Analysis file"

