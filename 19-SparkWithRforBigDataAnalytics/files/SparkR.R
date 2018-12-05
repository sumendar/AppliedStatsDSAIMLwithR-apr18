# https://github.com/sumendar/spark-r-notebooks
# fork the above repo into github account and clone into local machine
# goto notebook directory then starting with nb0-starting-up to nb4-linear-models directories of each notebook and practice according to it
## first install spark on window using the document https://github.com/sumendar/AppliedStatsDSAIMLwithR-apr18/blob/master/18-SparkRforBigDataAnalytics/docs/alfredogmarquez.com-.pdf 

###### from the document to check proper installation#########
Sys.getenv() # to check the environment variables properly incorporated according the document

library(tidyverse)

.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
library(SparkR)
# alternative to above code
# library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(
enableHiveSupport = FALSE ,
master = "local[*]",
sparkHome = Sys.getenv("SPARK_HOME") ,
sparkConfig =
list(spark.driver.memory = "2g",
spark.sql.warehouse.dir="C:\\Apps\\winutils\\winutilsmaster\\
hadoop-2.7.1")
)
sparkR.uiWebUrl()

df <- as.DataFrame(faithful)
str(df)

createOrReplaceTempView(df, "df")

waiting_70 <- SparkR::sql("select * from df where waiting > 70")
str(waiting_70)

head(SparkR::collect(waiting_70), 10)

SparkR::collect(SparkR::summary(df))

SparkR::corr(df, "waiting", "eruptions")

waiting_avg <- SparkR::select(df, SparkR::mean(df$waiting)) %>% SparkR::collect()

eruptions_avg <- SparkR::select(df, SparkR::mean(df$eruptions)) %>% SparkR::collect()
  
df %>% SparkR::collect() %>%
  ggplot(aes(x = waiting, y = eruptions)) +
  geom_point() +
  geom_smooth() +
  geom_vline(xintercept = waiting_avg$`avg(waiting)`) +
  geom_hline(yintercept = eruptions_avg$`avg(eruptions)`)
############### end the document code #############
# load the datasets (https://www.kaggle.com/census/2013-american-community-survey) and save it into proper folder 

###### nb0-starting-up #########

###############################

###### nb1-spark-sql-basics #########
sc <- sparkR.session(master='local', sparkPackages="com.databricks:spark-csv_2.11:1.2.0")

sqlContext <- sparkR.session(sc)

getwd() # data files should be in working directory 
housing_a_file_path <- file.path(setwd("~"), 'nfs','data','2013-acs','ss13husa.csv')
housing_b_file_path <- file.path(setwd("~"), 'nfs','data','2013-acs','ss13husb.csv')

system.time(
housing_a_df <- read.df(sqlContext,
housing_a_file_path,
header='true',
source = "com.databricks.spark.csv",
inferSchema='true')
)

system.time(
printSchema(housing_a_df)
)
dim(housing_a_df)
head(housing_a_df[,215:231])
?nrow
nrow(housing_a_df)
#Let's read the second housing data frame and count the number of rows.
system.time(
  housing_b_df <- read.df(sqlContext, 
                          housing_b_file_path, 
                          header='true', 
                          source = "com.databricks.spark.csv", 
                          inferSchema='true')
)
print(nrow(housing_b_df))

# Merging data frames
?rbind
housing_df <- rbind(housing_a_df, housing_b_df)
# And let's count how many rows do we have in the complete data frame.
system.time(
  housing_samples <- nrow(housing_df)
)
print(housing_samples)

# Finally, let's get a feeling of what is to explore data using SparkR by using the summary function on the data frame. Let's first have a look at the documentation.
?summary
system.time(
  housing_summary <- SparkR::describe(housing_df)
)

collect(housing_summary)

collect(select(housing_summary,"VALP"))


###############################

########## nb2-spark-sql-operations ######################
SparkR::head(housing_df)

# Giving ggplot2 a try
library(ggplot2)
# c <- ggplot(data=housing_df, aes(x=factor(REGION)))
housing_region_df_local <- collect(select(housing_df,"REGION"))
str(housing_region_df_local)
housing_region_df_local$REGION <- factor(
  x=housing_region_df_local$REGION, 
  levels=c(1,2,3,4,9),
  labels=c('Northeast', 'Midwest','South','West','Puerto Rico')
)
c <- ggplot(data=housing_region_df_local, aes(x=factor(REGION)))
c + geom_bar() + xlab("Region")

# Data selection¶
?select
collect(select(housing_df, "REGION", "VALP"))

###############################








