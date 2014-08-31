###########################
#File: plot5.R            #
#Author: Steeve Brechmann #
#Date: 22AUG2014          #
###########################

#Clear the workspace
rm(list=ls())

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

#Subset the data_merge to include only the Baltimore city
data_subset <- subset(data_merge, data_merge$fips=="24510")

#Compute the total emission of PM25 created by motor vehicle sources in Baltimore
data <- aggregate(data_subset$emissions, by=list(data_subset$year), sum)

#Rename the columns appropriately
names(data) <- c("year", "totalPM25")

#Create plot5.png
png(filename="plot5.png", width=600, height=480, units="px")
with(data, plot(data$year, data$totalPM25, xlab="Year", ylab="Total PM25 emissions [tons]", type="b", 
                main="Total PM25 emission of motor vehicle sources by years in Baltimore", col="blue"))
dev.off()

#Clear the workspace
rm(list=ls())

#Q: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#A: The emissions from motor vehicles sources have decreased in Baltimore City from 1999-2008.