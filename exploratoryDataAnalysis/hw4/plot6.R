# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
#    vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen
#    greater changes over time in motor vehicle emissions?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

code <- SCC[grep("Motor", SCC$Short.Name), "SCC"]
NEI_motor <- subset(NEI, SCC %in% code)

mt99_b <- subset(NEI_motor, year == 1999 & fips == "24510")
mt02_b <- subset(NEI_motor, year == 2002 & fips == "24510")
mt05_b <- subset(NEI_motor, year == 2005 & fips == "24510")
mt08_b <- subset(NEI_motor, year == 2008 & fips == "24510")

x99mt_b <- mt99_b$Emissions
x02mt_b <- mt02_b$Emissions
x05mt_b <- mt05_b$Emissions
x08mt_b <- mt08_b$Emissions

mt99_la <- subset(NEI_motor, year == 1999 & fips == "06037")
mt02_la <- subset(NEI_motor, year == 2002 & fips == "06037")
mt05_la <- subset(NEI_motor, year == 2005 & fips == "06037")
mt08_la <- subset(NEI_motor, year == 2008 & fips == "06037")

x99mt_la <- mt99_la$Emissions
x02mt_la <- mt02_la$Emissions
x05mt_la <- mt05_la$Emissions
x08mt_la <- mt08_la$Emissions

par(mfrow=c(2, 1))

barplot(c(sum(x99mt_b), sum(x02mt_b), sum(x05mt_b), sum(x08mt_b)), xlab="Year", ylab="Motor Related PM2.5 Emission, Baltimore, MD", names.arg=c("1999", "2002", "2005", "2008"))
barplot(c(sum(x99mt_la), sum(x02mt_la), sum(x05mt_la), sum(x08mt_la)), xlab="Year", ylab="Motor Related PM2.5 Emission, Los Angeles, CA", names.arg=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot6.png")
dev.off()