# create a directory for the work
if(!dir.exists("TurkishNames")) {
        dir.create("TurkishNames")
}

# set working directory
setwd("TurkishNames")

# getting the data from TUIK (Turkish Statistics Institute)
maleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1332"
femaleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1331"

# download files
if(!file.exists("male.xls")){
        download.file(maleURL, destfile = "male.xls") 
}

if(!file.exists("female.xls")){
        download.file(femaleURL, destfile = "female.xls") 
}

# get data in the general environment
library(xlsx)
maleNames <- read.xlsx("male.xls", sheetIndex = 1, header = FALSE)
femaleNames <- read.xlsx("female.xls", sheetIndex = 1, header = FALSE)

# examine the data
head(maleNames, 10)
tail(maleNames, 10)
head(femaleNames, 10)
tail(femaleNames, 10)

# rename header
header <- maleNames[5, ]
# there are factor variables in this row.
# correct factor variables

header[1] <- "name"
header[ ,2] <- 1950
header[ ,15] <- 1990
header[ ,28] <- 2003
# now rename the header. we can use it for both maleNames and femaleNames dataframes
names(maleNames) <- header
names(femaleNames) <- header

# removing the rows with description
maleNames <- maleNames[7:289, ] # we need to remove the first 6 rows and the rows after 289
femaleNames <- femaleNames[7:321, ] # we need to remove the first 6 rows and the rows after 321

# turn our data into tabular form with 3 variables: name, year and rank
library(tidyr)
maleNamesTidy <- gather(maleNames, key = name, value = rank, na.rm = TRUE)
names(maleNamesTidy) <- c("name", "year", "rank")
femaleNamesTidy <- gather(femaleNames, key = name, value = rank, na.rm = TRUE)
names(femaleNamesTidy) <- c("name", "year", "rank")

# we can combine these two data frames. However, it had better to add a factor variable sex.
library(dplyr)
maleNamesTidy <- mutate(maleNamesTidy, sex = "M")
femaleNamesTidy <- mutate(femaleNamesTidy, sex = "F")
namesData <- rbind(maleNamesTidy, femaleNamesTidy)

# save the tidy data
write.csv(namesData, file = "namesData.csv")
