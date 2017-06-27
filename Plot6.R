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

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

subset_data <- nei_data[nei_data$fips == "24510"|nei_data$fips == "06037", ]

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot6.png", width = 480, height = 480, units = "px", bg = "transparent")
motor <- grep("motor", scc_data$Short.Name, ignore.case = T)
motor <- scc_data[motor, ]
motor <- subset_data[subset_data$SCC %in% motor$SCC, ]

g <- ggplot(motor, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") + scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()
