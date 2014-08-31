###########################
#File: plot4.R            #
#Author: Steeve Brechmann #
#Date: 22AUG2014          #
###########################

#Clear the workspace
rm(list=ls())

#Load the data
rawdata <-  read.csv2("household_power_consumption.txt", na.strings="?", dec=".", 
                      colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                   "numeric", "numeric", "numeric", "numeric"))

#Transform epcdata$Date as a date class
rawdata$Date <- as.POSIXct(paste(rawdata$Date, rawdata$Time), format="%d/%m/%Y %H:%M:%S")

#Subsetting the raw data in "2007-02-01" <= Date <= "2007-02-02"
epcdata <- subset(rawdata, rawdata$Date >= "2007-02-01 00:00:00" & rawdata$Date <= "2007-02-02 23:59:59")

#Clear memory
rm(rawdata)

#Open the png file device
png(filename="plot4.png", width=480, height=480, units="px")

#Create the fourth plot
par(mfrow=c(2,2))
with(epcdata, 
{
  plot(epcdata$Date, epcdata$Global_active_power, xlab=NA, ylab="Global Active Power", type="l");
  plot(epcdata$Date, epcdata$Voltage, xlab="datetime", ylab="Voltage", type="l");
  with(epcdata, 
  {
    plot(epcdata$Date, epcdata$Sub_metering_1, xlab=NA, ylab=NA, type="l", col="black")
    par(new=TRUE)
    plot(epcdata$Date, epcdata$Sub_metering_2, xlab=NA, ylab=NA, type="l", col="red", 
         ylim=c(0, max(epcdata$Sub_metering_1)), axes=FALSE)
    par(new=TRUE)
    plot(epcdata$Date, epcdata$Sub_metering_3, xlab=NA, ylab="Energy sub metering", type="l", col="blue", 
         ylim=c(0, max(epcdata$Sub_metering_1)), axes=FALSE)
    legend("topright", lty=1 , col=c("black", "red", "blue"), bty="n", 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  });
  plot(epcdata$Date, epcdata$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
})

#Close the png file device
dev.off()

#Clear the workspace
rm(list=ls())
