###########################
#File: plot2.R            #
#Author: Steeve Brechmann #
#Date: 01SEP2014          #
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
png(filename="plot2.png", width=480, height=480, units="px")

#Create the scatter plot
plot(epcdata$Date, epcdata$Global_active_power, xlab=NA, ylab="Global Active Power (kilowatts)", type="l")

#Close the png file device
dev.off()

#Clear the workspace
rm(list=ls())
