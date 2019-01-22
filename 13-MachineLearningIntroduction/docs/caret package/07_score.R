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

# results
cm <- confusionMatrix(model$pred$pred, 
                      model$pred$obs,
                      positive = 'pos')
cm
cm$overall                # Accuracy
cm$table                  # Confusion Matrix
cm$byClass[['F1']]        # F1


