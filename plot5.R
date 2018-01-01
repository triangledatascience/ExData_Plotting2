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
#Question 5
####################

library(ggplot2)

NEI_Baltimore = subset(NEI, fips == "24510")
NEI_Baltimore = transform(NEI_Baltimore, year=as.factor(as.character(year)))
SCC$Vehicle = grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_Vehicle = SCC[SCC$Vehicle == TRUE,"SCC"]
NEI_Baltimore_Vehicle = NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_Vehicle,]

png("plot5.png", width=480, height=480)
plot5 <- ggplot(NEI_Baltimore_Vehicle, aes(x = year, y = Emissions)) + 
    geom_bar(stat="identity") + 
    labs(x="year", y=expression("Total tons of PM"[2.5]*" emitted")) + 
    labs(title=expression("Baltimore annual total PM"[2.5]*" emission from motor vehicle sources")) + 
    theme(plot.title = element_text(hjust = 0.5))
print(plot5)
dev.off()