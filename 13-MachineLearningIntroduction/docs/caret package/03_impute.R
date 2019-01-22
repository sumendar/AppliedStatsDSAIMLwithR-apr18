library(mlbench)
library(caret)
library(ggplot2)

data(PimaIndiansDiabetes2)
pid <- PimaIndiansDiabetes2

missing <- function(col) {
  return(sum(is.na(col)))
}

sapply(pid, missing)

#sapply(pid, function(col) { sum(is.na(col))})

# make a copy
imputed_glucose <- pid$glucose

# simple fix
summary(imputed_glucose)
imputed_glucose[is.na(imputed_glucose)] <- 
  mean(imputed_glucose, na.rm = TRUE)
summary(imputed_glucose)

# caret impute
?preProcess
impute_model <- preProcess(pid, method="knnImpute")
pid_imputed <- predict(impute_model, pid)
sapply(pid_imputed, missing)

# examine results
head(pid$glucose)
head(pid_imputed$glucose)
pid_imputed$glucose[is.na(pid$glucose)]
