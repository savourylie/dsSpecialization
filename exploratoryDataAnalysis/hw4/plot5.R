# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

barplot(c(sum(x99mt_b), sum(x02mt_b), sum(x05mt_b), sum(x08mt_b)), xlab="Year", ylab="Motor Related PM2.5 Emission, Baltimore, MD", names.arg=c("1999", "2002", "2005", "2008"))

dev.copy(png, file = "plot5.png")
dev.off()