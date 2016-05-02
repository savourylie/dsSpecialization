# 3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for
# Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2
# plotting system to make a plot answer this question.
library('ggplot2')
library('grid')
library('gridExtra')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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

nonroad <- subset(NEI, type=='NON-ROAD' & fips == "24510")
onroad <- subset(NEI, type=='ON-ROAD' & fips == "24510")
point <- subset(NEI, type=='POINT' & fips == "24510")
nonpoint <- subset(NEI, type=='NONPOINT' & fips == "24510")

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

t1 <- ggplot(point_sum, aes(year, total.emission)) + geom_bar(stat="identity") + ggtitle("POINT")
t2 <- ggplot(nonpoint_sum, aes(year, total.emission)) + geom_bar(stat="identity") + ggtitle("NON-POINT")
t3 <- ggplot(onroad_sum, aes(year, total.emission)) + geom_bar(stat="identity") + ggtitle("ONROAD")
t4 <- ggplot(nonroad_sum, aes(year, total.emission)) + geom_bar(stat="identity") + ggtitle("NONROAD")

multiplot(t1, t2, t3, t4, cols=2)

dev.copy(png, file = "plot3.png")
dev.off()