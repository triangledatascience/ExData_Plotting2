####################
#read data
####################

if(!file.exists("./NEI_data")){dir.create("./NEI_data")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile="./NEI_data.zip")
unzip(zipfile="./NEI_data.zip",exdir="./NEI_data")
setwd("./NEI_data")
getwd()
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

####################
#Question 1
####################

emissions_by_yr = with(NEI, tapply(Emissions, year, sum))
emissions_by_yr = emissions_by_yr/1000000
png("plot1.png", width=480, height=480)
barplot(emissions_by_yr
        , xlab="year"
        , ylab="Total tons of PM2.5 emitted (in millions)"
        , ylim=c(0, ceiling(range(emissions_by_yr)[2]))
)
title(main="US total PM2.5 emission by year")
dev.off()