###########################
#File: plot3.R            #
#Author: Steeve Brechmann #
#Date: 01SEP2014          #
###########################

#Clear the workspace
rm(list=ls())

#Load the ggplot2 library
library(ggplot2)

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

#Transform the pollutant type to a factor
datasub$type <- factor(datasub$type)

#Compute the total emission of PM25 by year and type
data <- aggregate(datasub$emissions, by=list(datasub$year, datasub$type), sum)

#Rename the columns appropriately
names(data) <- c("year", "type", "totalPM25")

#Create plot3.png
g <- ggplot(data, aes(year, totalPM25))
p <- g + geom_point() + facet_grid(. ~ type) + geom_smooth(method="loess") +
  labs(title="Total PM25 emissions in Baltimore by year and type") + labs(x="Year", y="Total PM25 emissions [tons]")
print(p)
dev.copy(png, "plot3.png", width=800, height=600)
dev.off()

#Clear the workspace
rm(list=ls())

#Q: Of the four types of sources indicated by the type variable, which of these four sources have seen increases in emissions from 1999 to 2008?
#A: Globally, there is only an increase with the point type.
