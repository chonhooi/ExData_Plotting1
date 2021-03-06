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
png("plot2.png", width=480, height=480)

# plot 2 
plot(filteredData$Time, filteredData$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

# disable device
dev.off()