## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#    Using the base plotting system, make a plot showing the total PM2.5 emission from all
#    sources for each of the years 1999, 2002, 2005, and 2008.

pm99 <- subset(NEI, year == 1999)
pm02 <- subset(NEI, year == 2002)
pm05 <- subset(NEI, year == 2005)
pm08 <- subset(NEI, year == 2008)

x99 <- pm99$Emissions
x02 <- pm02$Emissions
x05 <- pm05$Emissions
x08 <- pm08$Emissions

barplot(c(sum(x99), sum(x02), sum(x05), sum(x08)), xlab="Year", ylab="Total PM2.5 Emission", names.arg=c("1999", "2002", "2005", "2008"))

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

pm99md <- subset(NEI, year == 1999 & fips == "24510")
pm02md <- subset(NEI, year == 2002 & fips == "24510")
pm05md <- subset(NEI, year == 2005 & fips == "24510")
pm08md <- subset(NEI, year == 2008 & fips == "24510")

x99md <- pm99md$Emissions
x02md <- pm02md$Emissions
x05md <- pm05md$Emissions
x08md <- pm08md$Emissions

barplot(c(sum(x99md), sum(x02md), sum(x05md), sum(x08md)), xlab="Year", ylab="Total PM2.5 Baltimore City, MD", names.arg=c("1999", "2002", "2005", "2008"))

# 3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for
# Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2
# plotting system to make a plot answer this question.

library('ggplot2')
library('grid')
library('gridExtra')

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

nonroad <- subset(NEI, type=='NON-ROAD')
onroad <- subset(NEI, type=='ON-ROAD')
point <- subset(NEI, type=='POINT')
nonpoint <- subset(NEI, type=='NONPOINT')

point_sum <- tapply(point$Emissions, point$year, sum)
nonpoint_sum <- tapply(nonpoint$Emissions, nonpoint$year, sum)
onroad_sum <- tapply(onroad$Emissions, onroad$year, sum)
nonroad_sum <- tapply(nonroad$Emissions, nonroad$year, sum)

df <- data.frame(point_sum)
df['year'] <- row.names(df)
row.names(df) <- NULL
point_sum <- df
colnames(point_sum)[1] <- 'total.emission'
point_sum$year <- as.factor(point_sum$year)

df <- data.frame(nonpoint_sum)
df['year'] <- row.names(df)
row.names(df) <- NULL
nonpoint_sum <- df
colnames(nonpoint_sum)[1] <- 'total.emission'
nonpoint_sum$year <- as.factor(nonpoint_sum$year)

df <- data.frame(onroad_sum)
df['year'] <- row.names(df)
row.names(df) <- NULL
onroad_sum <- df
colnames(onroad_sum)[1] <- 'total.emission'
onroad_sum$year <- as.factor(onroad_sum$year)

df <- data.frame(nonroad_sum)
df['year'] <- row.names(df)
row.names(df) <- NULL
nonroad_sum <- df
colnames(nonroad_sum)[1] <- 'total.emission'
nonroad_sum$year <- as.factor(nonroad_sum$year)

t1 <- ggplot(point_sum, aes(year, total.emission)) + geom_bar(stat="identity")
t2 <- ggplot(nonpoint_sum, aes(year, total.emission)) + geom_bar(stat="identity")
t3 <- ggplot(onroad_sum, aes(year, total.emission)) + geom_bar(stat="identity")
t4 <- ggplot(nonroad_sum, aes(year, total.emission)) + geom_bar(stat="identity")

multiplot(t1, t2, t3, t4, cols=2)

# 4. Across the United States, how have emissions from coal combustion-related sources changed
#    from 1999–2008?

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

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

code <- SCC[grep("Motor", SCC$Short.Name), "SCC"]
NEI_motor <- subset(NEI, SCC %in% code)


# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
#    vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen
#    greater changes over time in motor vehicle emissions?



