NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pm99 <- subset(NEI, select = 'Emissions', year == 1999)
pm02 <- subset(NEI, select = 'Emissions', year == 2002)
pm05 <- subset(NEI, select = 'Emissions', year == 2005)
pm08 <- subset(NEI, select = 'Emissions', year == 2008)

pm99_sum <- sum(pm99$Emissions)
pm02_sum <- sum(pm02$Emissions)
pm05_sum <- sum(pm05$Emissions)
pm08_sum <- sum(pm08$Emissions)

