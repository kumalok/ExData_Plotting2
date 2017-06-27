#Course Directory
dir_local <- "exp_data_analysis_project2"
if(!file.exists(dir_local)){
	dir.create(dir_local)
}

#Set working directory
setwd(dir_local)

#download and extract data in working directory
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destination_file <- "dataset.zip"
if(!file.exists(destination_file)){
	download.file(data_url, destfile = destination_file)
	unzip(destination_file)
}

if (!"nei_data" %in% ls()) {
  nei_data <- readRDS("summarySCC_PM25.rds")
}
if (!"scc_data" %in% ls()) {
  scc_data <- readRDS("Source_Classification_Code.rds")
}

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system,make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

library(grDevices)
par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "plot1.png",width = 480, height = 480,units = "px")

total_emissions <- aggregate(nei_data$Emissions, list(nei_data$year), FUN = "sum")

plot(total_emissions, type = "l", xlab = "Year", 
     main = "Total Emissions in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()