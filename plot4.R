library(ggplot2)

#Read input data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./dataset.zip")
unzip(zipfile="./dataset.zip",exdir="./dataset")

dataFile <- "./dataset/household_power_consumption.txt"

#dataset missing values are coded as "?"
plotData <- read.table(dataFile, header = T, sep=";", na.strings="?")

#Convert date/time stamps
plotData$Date <- as.Date(plotData$Date, format = "%d/%m/%Y")

#Gets subset of data for dates 2007-02-01 and 2007-02-02
#Set the date time for the plot generation
subset <- subset(plotData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
setDateTime <- strptime(paste(subset$Date, subset$Time), "%Y-%m-%d %H:%M:%S")

#Gets "Global_active_power" of data from subset
globalActivePowerData <- as.numeric(subset$Global_active_power)

#Gets "Global_reactive_power" of data from subset
globalReactivePowerData <- as.numeric(subset$Global_reactive_power)

#Gets "Voltage" of data from subset
voltageData <- as.numeric(subset$Voltage)

#Get sub-metering data for energy from subset
subMetering1Data <- as.numeric(subset$Sub_metering_1)
subMetering2Data <- as.numeric(subset$Sub_metering_2)
subMetering3Data <- as.numeric(subset$Sub_metering_3)

#PNG file with a width of 480 pixels and a height of 480 pixels
png("plot4.png", width=480, height=480)

#Construct plots (4 total)
par(mfrow = c(2, 2))

#Global Active Power Plot
plot(setDateTime, globalActivePowerData, type="l", xlab="", ylab="Global Active Power")

#Voltage Plot
plot(setDateTime, voltageData, type="l", xlab="", ylab="Voltage")

#Submetering Plot(s) with legend (no box)
plot(setDateTime, subMetering1Data, type = "l",  ylab = "Energy sub metering", xlab = "")
lines(setDateTime, subMetering2Data, col = "Red")
lines(setDateTime, subMetering3Data, col = "Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, col=c("black", "red", "blue"), bty="n")

#Global Active Power Plot
plot(setDateTime, globalReactivePowerData, type="l", xlab="", ylab="Global_reactive_power")


dev.off()