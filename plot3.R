# plot3.R

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

# Save plot to PNG
png("plot3.png", width=480, height=480)

# Plot sub-metering 1
plot(data_subset$DateTime, data_subset$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", xaxt="n")

# Add sub-metering 2 and 3
lines(data_subset$DateTime, data_subset$Sub_metering_2, col="red")
lines(data_subset$DateTime, data_subset$Sub_metering_3, col="blue")

# Customize x axis labels
days <- c("Thu", "Fri", "Sat")
midnights <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis(1, at=midnights, labels=days)

# Add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)

dev.off()