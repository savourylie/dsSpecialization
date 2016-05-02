# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pm99md <- subset(NEI, year == 1999 & fips == "24510")
pm02md <- subset(NEI, year == 2002 & fips == "24510")
pm05md <- subset(NEI, year == 2005 & fips == "24510")
pm08md <- subset(NEI, year == 2008 & fips == "24510")

x99md <- pm99md$Emissions
x02md <- pm02md$Emissions
x05md <- pm05md$Emissions
x08md <- pm08md$Emissions

barplot(c(sum(x99md), sum(x02md), sum(x05md), sum(x08md)), xlab="Year", ylab="Total PM2.5 Baltimore City, MD", names.arg=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot2.png")
dev.off()