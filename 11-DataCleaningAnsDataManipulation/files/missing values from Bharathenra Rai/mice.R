# Libraries
library(mice)
library(VIM)

# Data
data <- read.csv(file.choose(), header = T)
str(data)
summary(data)

# Missing data
p <- function(x) {sum(is.na(x))/length(x)*100}
apply(data, 2, p)
md.pattern(data)
md.pairs(data)
marginplot(data[,c('Mileage', 'lc')])

# Impute
impute <- mice(data[,2:7], m=3, seed = 123)
print(impute)
impute$imp$State

# Complete data
newDATA <- complete(impute, 1)

# Distribution of oberserved/imputed values
stripplot(impute, pch = 20, cex = 1.2)
xyplot(impute, lc ~ lh | .imp, pch = 20, cex=1.4)
