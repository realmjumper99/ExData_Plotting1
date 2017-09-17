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

# plot the various charts in a 2x2 matrix/table thingy
png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

# Create a  plot of the Global Active Power in top left
plot(x=pdata$DateTime,y=pdata$Global_active_power, type="l", ylab="Global Active power (kilowatts)", xlab="")

# Create plot of Voltage in top right
plot(x=pdata$DateTime,y=pdata$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Create a plot of the submetering and add the other sub metering lines in bottom left
plot(x=pdata$DateTime,y=pdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(x=pdata$DateTime,y=pdata$Sub_metering_2,col="red")
lines(x=pdata$DateTime,y=pdata$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

# Create plot of Global Reactive power in bottom right
plot(x=pdata$DateTime,y=pdata$Global_reactive_power, type="l", ylab="Global Active power (kilowatts)", xlab="datetime")
dev.off()