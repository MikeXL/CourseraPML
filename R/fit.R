#
# download the data from internet
#

pml_train <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"))
pml_testing <- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"))

#
# save for future use
#
save(pml_train, pml_testing, file="data/pml.RData")

# split the dataset into training and Validation
# the testing dataset is actually for prediction
trainIndex <- createDataPartition(..., p=.7)
train    <- pml_train[trainIndex, ]
validate <- pml_train[-trainIndex, ]
new.data <- pml_testing


features <- c(roll_belt,
              pitch_belt,
              yaw_belt,
              accel_belt_x,
              accel_belt_y,
              accel_belt_z,
              magnet_belt_x,
              magnet_belt_y,
              magnet_belt_z,
              roll_arm,
              pitch_arm,
              yaw_arm,
              accel_arm_x,
              accel_arm_y,
              accel_arm_z,
              magnet_arm_x,
              magnet_arm_y,
              magnet_arm_z,
              roll_dumbbell,
              pitch_dumbbell,
              yaw_dumbbell,
              accel_dumbbell_x,
              accel_dumbbell_y,
              accel_dumbbell_z,
              magnet_dumbbell_x,
              magnet_dumbbell_y,
              magnet_dumbbell_z,
              roll_forearm,
              pitch_forearm,
              yaw_forearm,
              accel_forearm_x,
              accel_forearm_y,
              accel_forearm_z,
              magnet_forearm_x,
              magnet_forearm_y,
              magnet_forearm_z)

#
# fit a KNN model
#
fit.knn <- knn(train[features], validate[features], train$classe, data=train)

#
# random forest
#
fit.forest <- randomForest(classe~	roll_belt+
                    pitch_belt+
                    yaw_belt+
                      accel_belt_x+
                    accel_belt_y+
                    accel_belt_z+
                    magnet_belt_x+
                    magnet_belt_y+
                    magnet_belt_z+
                    roll_arm+
                    pitch_arm+
                    yaw_arm+
                      accel_arm_x+
                    accel_arm_y+
                    accel_arm_z+
                    magnet_arm_x+
                    magnet_arm_y+
                    magnet_arm_z+
                      roll_dumbbell+
                    pitch_dumbbell+
                    yaw_dumbbell+
                      accel_dumbbell_x+
                    accel_dumbbell_y+
                    accel_dumbbell_z+
                    magnet_dumbbell_x+
                    magnet_dumbbell_y+
                    magnet_dumbbell_z+
                    roll_forearm+
                    pitch_forearm+
                    yaw_forearm+
                      accel_forearm_x+
                    accel_forearm_y+
                    accel_forearm_z+
                    magnet_forearm_x+
                    magnet_forearm_y+
                    magnet_forearm_z, data=train, importance=T)

#
# grow a simple treetree
#

fit.tree <- rpart(classe~	roll_belt+
                      pitch_belt+
                      yaw_belt+
                      accel_belt_x+
                      accel_belt_y+
                      accel_belt_z+
                      magnet_belt_x+
                      magnet_belt_y+
                      magnet_belt_z+
                      roll_arm+
                      pitch_arm+
                      yaw_arm+
                      accel_arm_x+
                      accel_arm_y+
                      accel_arm_z+
                      magnet_arm_x+
                      magnet_arm_y+
                      magnet_arm_z+
                      roll_dumbbell+
                      pitch_dumbbell+
                      yaw_dumbbell+
                      accel_dumbbell_x+
                      accel_dumbbell_y+
                      accel_dumbbell_z+
                      magnet_dumbbell_x+
                      magnet_dumbbell_y+
                      magnet_dumbbell_z+
                      roll_forearm+
                      pitch_forearm+
                      yaw_forearm+
                      accel_forearm_x+
                      accel_forearm_y+
                      accel_forearm_z+
                      magnet_forearm_x+
                      magnet_forearm_y+
                      magnet_forearm_z, data=train, importance=T)

#
# x validation
#
table(predict(fit.knn, validation), validation)
table(predict(fit.forest, validation), validation)
table(predict(fit.tree, validation), validation)

#
# plot the tree and forest, as well as the variables importancy
#
plot(fit.forest)
varImpPlot(fit.forest)

fancyRpartPlot(fit.tree)
varImpPlot(fit.tree)
