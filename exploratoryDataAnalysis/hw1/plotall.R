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

# Plot1.R
hist(data$Global_active_power, col='red', main="Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()

# Plot2.R
plot(data$DateTime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)", main = "")
lines(data$DateTime, data$Global_active_power, type = "l")

dev.copy(png, file = "plot2.png")
dev.off()

# Plot3.R
plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type='n')
lines(data$DateTime, data$Sub_metering_1, type = "l")
lines(data$DateTime, data$Sub_metering_2, type = "l", col='red')
lines(data$DateTime, data$Sub_metering_3, type = "l", col='blue')
legend('topright', lwd=c(2.5, 2.5, 2.5), col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()

# Plot4.R
par(mfrow=c(2, 2))

plot(data$DateTime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power", main = "")
lines(data$DateTime, data$Global_active_power, type = "l")

plot(data$DateTime, data$Voltage, type='n', xlab = "datetime", ylab = "Voltage", main = "")
lines(data$DateTime, data$Voltage, type = "l")

plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type='n')
lines(data$DateTime, data$Sub_metering_1, type = "l")
lines(data$DateTime, data$Sub_metering_2, type = "l", col='red')
lines(data$DateTime, data$Sub_metering_3, type = "l", col='blue')
legend('topright', lwd=c(2.5, 2.5, 2.5), col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$DateTime, data$Global_reactive_power, type='n', xlab = "datetime", ylab = "Global_reactive_power", main = "")
lines(data$DateTime, data$Global_reactive_power, type = "l")

dev.copy(png, file = "plot4.png")
dev.off()


