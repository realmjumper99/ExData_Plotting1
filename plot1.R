#Make sure that your working directory contains the file household_power_consumption.txt
#This file can be downloaded and extracted from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#
# Read in the file from line 66635 to 69520
# This will capture more than is needed but i want the wiggle room to make sure I didn't miss count
headers <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data <- read.csv(file="household_power_consumption.txt", sep=";", na.strings="?", header = TRUE, skip = 66635, nrows = 2885, col.names = headers)

# convert the data in the first column into a date then subset only those whose year is 2007
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date>"2006-01-31" & Date<"2007-02-03")

# Create a histogram plot of the Global Active Power
png("plot1.png",width = 480, height = 480)
hist(data$Global_active_power,col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power", xlim=c(0,6))
dev.off()