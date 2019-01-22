library(mlbench)
library(caret)
library(ggplot2)

data(PimaIndiansDiabetes2)
pid <- PimaIndiansDiabetes2

# caret impute
impute_model <- preProcess(pid, method="knnImpute")
pid <- predict(impute_model, pid)

# split (stratified by default)
train_idx <- createDataPartition(pid$diabetes, p = .7, list = FALSE)

train <- pid[train_idx,]
test <- pid[-train_idx,]

dim(train)
dim(test)

# verify split size
length(train_idx) / length(pid$diabetes)
dim(train)[1] / length(pid$diabetes)
