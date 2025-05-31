# plot1.R

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = zipFile, mode = "wb")
}

if (!file.exists(dataFile)) {
  unzip(zipFile)
}

data <- read.table(dataFile, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

data_subset <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(data_subset$Global_active_power),
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")
dev.off()