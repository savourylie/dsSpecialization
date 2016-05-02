# 4. Across the United States, how have emissions from coal combustion-related sources changed
#    from 1999–2008?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_coal <- subset(NEI, SCC=="10100101")

cl99 <- subset(NEI_coal, year == 1999)
cl02 <- subset(NEI_coal, year == 2002)
cl05 <- subset(NEI_coal, year == 2005)
cl08 <- subset(NEI_coal, year == 2008)

x99cl <- cl99$Emissions
x02cl <- cl02$Emissions
x05cl <- cl05$Emissions
x08cl <- cl08$Emissions

barplot(c(sum(x99cl), sum(x02cl), sum(x05cl), sum(x08cl)), xlab="Year", ylab="Coal Related PM2.5 Emission", names.arg=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot4.png")
dev.off()
