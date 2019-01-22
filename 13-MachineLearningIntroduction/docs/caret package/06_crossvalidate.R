library(mlbench)
library(caret)
library(ggplot2)
set.seed(1)

data(PimaIndiansDiabetes2)
pid <- PimaIndiansDiabetes2

train_control<- trainControl(method="cv", 
                             number=10, 
                             savePredictions = TRUE)

model <- train(diabetes ~ .,
               method = "glm",
               data = pid,
               trControl = train_control,
               na.action = na.pass,
               preProcess = c("knnImpute"))

summary(model)

# Accuracy
sum(model$pred$pred == model$pred$obs) / nrow(model$pred)
