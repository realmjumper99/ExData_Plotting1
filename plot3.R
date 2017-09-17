#Make sure that your working directory contains the file household_power_consumption.txt
#This file can be downloaded and extracted from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#
# Read in the file from line 66635 to 69520
# This will capture more than is needed but i want the wiggle room to make sure I didn't miss count
headers <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
pdata <- read.csv(file="household_power_consumption.txt", sep=";", na.strings="?", header = TRUE, skip = 66635, nrows = 2885, col.names = headers)

# convert the data from the Date and Time into one column of POSIX Datetime then subset just the days of Feb 1 2007 and Feb 2 2007
pasted <- paste(pdata$Date,pdata$Time)
pdata[10] <- as.POSIXct(paste(pdata$Date,pdata$Time),format = "%d/%m/%Y %H:%M:%S")
colnames(pdata)[10] <- "DateTime"
pdata <- subset(pdata,DateTime>="2007-02-01" & DateTime<"2007-02-03")

# Create a plot of the submetering and add the other sub metering lines
png("plot3.png",width = 480, height = 480)
plot(x=pdata$DateTime,y=pdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(x=pdata$DateTime,y=pdata$Sub_metering_2,col="red")
lines(x=pdata$DateTime,y=pdata$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))
dev.off()