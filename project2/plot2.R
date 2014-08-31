###########################
#File: plot2.R            #
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

#Subset the NEI dataset to include only the Baltimore City
datasub <- subset(nei, nei$fips=="24510") 

#Compute the total emission of PM25 by year
data <- aggregate(datasub$emissions, by=list(datasub$year), sum)

#Rename the columns appropriately
names(data) <- c("year", "totalPM25")

#Create plot2.png
png(filename="plot2.png", width=480, height=480, units="px")
with(data, plot(data$year, data$totalPM25, xlab="Year", ylab="Total PM25 emissions [tons]", type="b", 
                main="Total PM25 emission by years in Baltimore", col="blue"))
dev.off()

#Clear the workspace
rm(list=ls())

#Q: Have the total emissions from PM25 decreased in Baltimore city from 1999 to 2008?
#A: Yes. Globally, there is a decrease.