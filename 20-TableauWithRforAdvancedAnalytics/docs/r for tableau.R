install.packages("Rserve")
library(Rserve)
Rserve()
write.csv(iris, "IrisData.csv")
