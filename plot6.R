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
#Question 6
####################

library(ggplot2)

NEI_Baltimore_LosAngeles = subset(NEI, fips == "24510" | fips == "06037")
NEI_Baltimore_LosAngeles$county[NEI_Baltimore_LosAngeles$fips == "24510"] = "Baltimore City"
NEI_Baltimore_LosAngeles$county[NEI_Baltimore_LosAngeles$fips == "06037"] = "Los Angeles County"
NEI_Baltimore_LosAngeles = transform(NEI_Baltimore_LosAngeles
                                     , year=as.factor(as.character(year)))
NEI_Baltimore_LosAngeles = transform(NEI_Baltimore_LosAngeles
                                     , county=as.factor(county))
SCC$Vehicle = grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_Vehicle = SCC[SCC$Vehicle == TRUE,"SCC"]
NEI_Baltimore_LosAngeles_Vehicle = NEI_Baltimore_LosAngeles[NEI_Baltimore_LosAngeles$SCC %in% SCC_Vehicle,]

png("plot6.png", width=480, height=480)
plot6 <- ggplot(NEI_Baltimore_LosAngeles_Vehicle, aes(x = year, y = Emissions)) + 
    geom_bar(stat="identity") + 
    facet_wrap(~county, nrow=1) +
    labs(x="year", y=expression("Total tons of PM"[2.5]*" emitted")) + 
    labs(title=expression("Total annual total PM"[2.5]*" emission in Baltimore vs. Los Angeles")) + 
    theme(plot.title = element_text(hjust = 0.5))
print(plot6)
dev.off()