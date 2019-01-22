library(mlbench)
library(ggplot2)

data(PimaIndiansDiabetes2)
pid <- PimaIndiansDiabetes2

head(pid)
summary(pid)
?PimaIndiansDiabetes2

examine_1var <- function(feature, title='') {
  qplot(diabetes, feature, color = diabetes, 
        main= title, data=pid, geom = "boxplot")
}

examine_2var <- function(feature1, feature2, xlab, ylab) {
  qplot(feature1, feature2, color = diabetes, 
        data=pid, geom = "point", xlab = xlab,
        ylab = ylab) 
}

examine_1var(pid$glucose, 'glucose')
examine_1var(pid$pressure, 'pressure')
examine_1var(pid$triceps, 'triceps')
examine_1var(pid$insulin, 'insulin')
examine_1var(pid$mass, 'mass')
examine_1var(pid$pedigree, 'pedigree')
examine_1var(pid$age, 'age')
examine_1var(pid$pregnant, 'pregnant')
examine_2var(pid$glucose, pid$insulin, 'glucose', 'insulin')
examine_2var(pid$glucose, pid$mass, 'glucose', 'mass')
examine_2var(pid$age, pid$mass, 'age', 'mass')
examine_2var(pid$pregnant, pid$mass, 'pregnant', 'mass')
examine_2var(pid$pregnant, pid$age, 'pregnant', 'age')
