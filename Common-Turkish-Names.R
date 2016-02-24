setwd("C:/data")

# getting the data from TUIK (Turkish Statistics Institute)
maleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1332"
femaleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1331"

if(!dir.exists("TurkishNames")) {
        dir.create("TurkishNames")
}

setwd("TurkishNames")

if(!file.exists("male.xls")){
        download.file(maleURL, destfile = "male.xls") 
}

if(!file.exists("female.xls")){
        download.file(femaleURL, destfile = "female.xls") 
}
