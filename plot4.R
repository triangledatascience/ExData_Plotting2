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
#Question 4
####################

library(ggplot2)

NEI = transform(NEI, year=as.factor(as.character(year)))
SCC$Comb = grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
SCC$Coal = grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
SCC$Comb_Coal = SCC$Comb & SCC$Coal
SCC_Comb_Coal = SCC[SCC$Comb_Coal == TRUE,"SCC"]
NEI_Comb_Coal = NEI[NEI$SCC %in% SCC_Comb_Coal,]

png("plot4.png", width=480, height=480)
plot4 <- ggplot(NEI_Comb_Coal, aes(x = year, y = Emissions/10^5)) + 
    geom_bar(stat="identity") + 
    labs(x="year", y=expression("Total tons of PM"[2.5]*" emitted (in 10^5)")) + 
    labs(title=expression("US annual total PM"[2.5]*" emission from coal combustion-related sources")) + 
    theme(plot.title = element_text(hjust = 0.5))
print(plot4)
dev.off()