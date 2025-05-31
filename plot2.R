# plot2.R

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

# Download and unzip if needed
if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = zipFile, mode = "wb")
}
if (!file.exists(dataFile)) {
  unzip(zipFile)
}

# Read and preprocess data
data <- read.table(dataFile, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Subset dates Feb 1 and Feb 2, 2007
data_subset <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Convert Global_active_power to numeric
gap <- as.numeric(data_subset$Global_active_power)

# Save plot to PNG
png("plot2.png", width=480, height=480)

plot(data_subset$DateTime, gap, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
days <- c("Thu", "Fri", "Sat")
midnights <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis(1, at=midnights, labels=days)

dev.off()