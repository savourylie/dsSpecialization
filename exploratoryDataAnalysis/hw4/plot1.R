# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#    Using the base plotting system, make a plot showing the total PM2.5 emission from all
#    sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pm99 <- subset(NEI, year == 1999)
pm02 <- subset(NEI, year == 2002)
pm05 <- subset(NEI, year == 2005)
pm08 <- subset(NEI, year == 2008)

x99 <- pm99$Emissions
x02 <- pm02$Emissions
x05 <- pm05$Emissions
x08 <- pm08$Emissions

barplot(c(sum(x99), sum(x02), sum(x05), sum(x08)), xlab="Year", ylab="Total PM2.5 Emission", names.arg=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot1.png")
dev.off()