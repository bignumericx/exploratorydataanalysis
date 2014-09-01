###########################
#File: plot4.R            #
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

#Find the coal combustion related sources from scc data set 
coal_comb <- scc[grep("[^char]coal", scc$ei_sector, ignore.case=TRUE), c("scc", "ei_sector")]

#Merge the nei and coal_comb data set
data_merge <- merge(nei, coal_comb, by="scc")

#Compute the total emission of PM25 created by coal combustion related sources
data <- aggregate(data_merge$emissions, by=list(data_merge$year), sum)

#Rename the columns appropriately
names(data) <- c("year", "totalPM25")

#Create plot4.png
png(filename="plot4.png", width=480, height=480, units="px")
with(data, plot(data$year, data$totalPM25/10000, xlab="Year", ylab="Total PM25 emissions [x10^4 tons]", type="b", 
                main="Total PM25 emission of coal combustion sources by years", col="blue"))
dev.off()

#Clear the workspace
rm(list=ls())

#Q: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#A: Globally, there is a decrease in the emissions from coal combustion-related sources.
