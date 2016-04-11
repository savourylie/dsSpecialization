# Load libraries
library(lubridate)

# Estimate the size of the dataset
top.size <- object.size(read.csv("household_power_consumption.txt", sep=';', nrow=1000))
lines <- as.numeric(gsub("[^0-9]", "", system("wc -l household_power_consumption.txt", intern=T)))
size.estimate <- lines / 1000 * top.size # 270945945.6 bytes

# Import Data
data_original <- read.csv("household_power_consumption.txt", sep=';', na.strings = "?")
data <- data_original

# Convert the Date and Time column from Factor to Date
data$Date <- dmy(data['Date'][,])
data$Time <- hms(data['Time'][,])

# Create DateTime column
data['DateTime'] <- data$Date + data$Time

# Create Day column
data["Day"] <- wday(data$Date)

# Subset to get the time period we are interested in
period <- data$Date == ymd("2007-02-01") | data$Date == ymd("2007-02-02")
data<- data[period, ]

# Plot2.R
plot(data$DateTime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)", main = "")
lines(data$DateTime, data$Global_active_power, type = "l")

dev.copy(png, file = "plot2.png")
dev.off()