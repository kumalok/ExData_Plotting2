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

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png", width = 480, height = 480, units = "px")
coal <- grep("coal", scc_data$Short.Name, ignore.case = T)
coal <- scc_data[coal, ]
coal <- nei_data[nei_data$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

plot(coalEmissions, type = "l", xlab = "Year", main = "Total Emissions From Coal Combustion-related\n Sources from 1999~2008", ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()
