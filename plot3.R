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
#Question 3
####################

library(dplyr)
library(ggplot2)

NEI_Baltimore = subset(NEI, fips == "24510")
NEI_Baltimore = transform(NEI_Baltimore, year=as.factor(as.character(year)))
NEI_Baltimore = transform(NEI_Baltimore, type=as.factor(type))
df3 = NEI_Baltimore %>%
    group_by(type, year) %>%
    summarize(Emissions=sum(Emissions))

png("plot3.png", width=480, height=480)
plot3 <- ggplot(NEI_Baltimore, aes(x = year, y = Emissions)) + 
    geom_bar(stat="identity") + 
    facet_wrap(~type, nrow=1) +
    labs(x="year", y=expression("Total tons of PM"[2.5]*" emitted")) + 
    labs(title=expression("Baltimore annual total PM"[2.5]*" emission by source")) + 
    theme(plot.title = element_text(hjust = 0.5))
print(plot3)
dev.off()