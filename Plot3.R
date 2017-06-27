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

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

subset_data <- nei_data[nei_data$fips == "24510", ]
library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(subset_data, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total Emissions in Baltimore City from 1999 ~ 2008")
dev.off()
