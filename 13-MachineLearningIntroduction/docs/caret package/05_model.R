library(mlbench)
library(caret)
library(ggplot2)
set.seed(1)

data(PimaIndiansDiabetes2)
pid <- PimaIndiansDiabetes2

train_idx <- createDataPartition(pid$diabetes, p = .7, 
                                 list = FALSE)
training <- pid[train_idx,]
testing <- pid[-train_idx,]

model <- train(diabetes ~ .,
               method = "glm",
               data = training,
               na.action = na.pass,
               preProcess = c("knnImpute"))

# https://en.wikipedia.org/wiki/Akaike_information_criterion
summary(model)

testing$predicted <- predict(model, 
                             newdata = testing,
                             na.action = na.pass)

# Accuracy
sum(testing$predicted == testing$diabetes) / nrow(testing)
