###########################
#File: plot1.R            #
#Author: Steeve Brechmann #
#Date: 01SEP2014          #
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

#Compute the total PM25 pollutant by years
data <- aggregate(nei$emissions, by=list(nei$year), sum)

#Rename the columns appropriately
names(data) <- c("year", "totalPM25")

#Create plot1.png
png(filename="plot1.png", width=480, height=480, units="px")
with(data, plot(data$year, data$totalPM25/1e6, xlab="Year", ylab="Total emissions [millions tons]", type="b", 
                main="Total PM25 emission by years", col="blue"))
dev.off()

#Clear the workspace
rm(list=ls())

#Q: Have total emissions from PM25 decreased in the United States from 1999 to 2008?
#A: Yes!
