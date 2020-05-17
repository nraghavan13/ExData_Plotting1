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

#Gets "Global_active_power" data from subset
globalActivePowerData <- as.numeric(subset$Global_active_power)

#PNG file with a width of 480 pixels and a height of 480 pixels
png("plot2.png", width=480, height=480)

#Construct plot
plot(setDateTime, globalActivePowerData, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()