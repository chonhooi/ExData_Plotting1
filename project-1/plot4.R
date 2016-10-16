# check if the library exists
if (!require(data.table))
{
    install.packages("data.table")
}

if (!require(dplyr))
{
    install.packages("dplyr")
}

# import libraries
library(data.table)
library(dplyr)

# load data
data <- fread("household_power_consumption.txt", na.strings = "?")

# format date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# filter data
filteredData <- filter(data, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))

# format time
filteredData$Time <- strptime(paste(filteredData$Date, filteredData$Time), "%Y-%m-%d %H:%M:%S")

# enable device
png("plot4.png", width=480, height=480)

# create 4 places
par(mfrow=c(2,2))

# plot 4
plot(filteredData$Time, filteredData$Global_active_power,
     col = "black",
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

plot(filteredData$Time, filteredData$Voltage,
     col = "black",
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

plot(filteredData$Time, filteredData$Sub_metering_1,
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")

lines(filteredData$Time, filteredData$Sub_metering_2,
      col = "red")

lines(filteredData$Time, filteredData$Sub_metering_3,
      col = "blue")

legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

plot(filteredData$Time, filteredData$Global_reactive_power,
     col = "black",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")

# disable device
dev.off()