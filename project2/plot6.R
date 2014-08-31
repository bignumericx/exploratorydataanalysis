###########################
#File: plot6.R            #
#Author: Steeve Brechmann #
#Date: 22AUG2014          #
###########################

#Clear the workspace
rm(list=ls())

#Load ggplot2
#library(ggplot2)

#Loading the two datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#Lower the case of attributes names
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(scc))

#Replace the "." for "_" in names(scc)
names(scc) <- gsub(".", "_", names(scc), fixed=TRUE)

#Find the motor vehicle in the scc data set
#Motor vehicle includes road vehicles, such as automobiles, vans, motorcycles, and trucks, as well as off-road 
#vehicles such as self-propelled construction and farming equipment
motor_vehicle <- scc[grep("^(.*)mobile(.*)road", scc$ei_sector, ignore.case=TRUE), c("scc", "ei_sector")]

#Merge the nei and motor_vehicle data set
data_merge <- merge(nei, motor_vehicle, by="scc")

#Subset the data_merge to include only the Baltimore and Los Angeles city
data_baltimore <- subset(data_merge, data_merge$fips=="24510")
data_losangeles<- subset(data_merge, data_merge$fips=="06037")

#Compute the total emission of PM25 created by motor vehicle sources in Baltimore
data_bal <- aggregate(data_baltimore$emissions, by=list(data_baltimore$year), sum)

#Compute the total emission of PM25 created by motor vehicle sources in Los Angeles
data_los <- aggregate(data_losangeles$emissions, by=list(data_losangeles$year), sum)

#Rename the columns appropriately
names(data_bal) <- c("year", "totalPM25")
names(data_los) <- c("year", "totalPM25")

#Create plot6.png
png(filename="plot6.png", width=600, height=480, units="px")
with(data_los, plot(data_los$year, data_los$totalPM25, xlab="Year", ylab="Total PM25 emissions [tons]", type="b",
                    col="red"))
par(new=TRUE)
with(data_bal, plot(data_bal$year, data_bal$totalPM25, xlab="Year", ylab="Total PM25 emissions [tons]", type="b", 
                main="Total PM25 emission of motor vehicle sources by years", col="blue", 
                ylim=c(0, max(data_los$totalPM25)), axes=FALSE))
legend("topright", lty=1, col=c("red", "blue"), bty="n", legend=c("Los Angeles", "Baltimore"))
dev.off()

#Clear the workspace
rm(list=ls())

#Q: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California
#   Which city has seen greater changes over time in motor vehicle emissions?
#A: Los Angeles city have seen greater changes over time in motor vehicle emissions.