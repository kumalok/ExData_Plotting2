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

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
subset_data <- nei_data[nei_data$fips == "24510", ] 

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot5.png", width = 480, height = 480, units = "px")
motor <- grep("motor", scc_data$Short.Name, ignore.case = T)
motor <- scc_data[motor, ]
motor <- subset_data[subset_data$SCC %in% motor$SCC, ]
motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

plot(motorEmissions, type = "l", xlab = "Year", main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City", ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()
