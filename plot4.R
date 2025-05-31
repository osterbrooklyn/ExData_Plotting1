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

# Plot png
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Define the days and their positions on x-axis
days <- c("Thu", "Fri", "Sat")
midnights <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

# Plot 1: Global Active Power
plot(data_subset$DateTime, as.numeric(data_subset$Global_active_power), type="l",
     xlab="", ylab="Global Active Power", xaxt="n")
axis(1, at=midnights, labels=days)

# Plot 2: Voltage
plot(data_subset$DateTime, as.numeric(data_subset$Voltage), type="l",
     xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=midnights, labels=days)

# Plot 3: Energy sub metering
plot(data_subset$DateTime, data_subset$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", xaxt="n")
lines(data_subset$DateTime, data_subset$Sub_metering_2, col="red")
lines(data_subset$DateTime, data_subset$Sub_metering_3, col="blue")
axis(1, at=midnights, labels=days)
legend("topright", col=c("black","red","blue"), lty=1, bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot 4: Global Reactive Power
plot(data_subset$DateTime, as.numeric(data_subset$Global_reactive_power), type="l",
     xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, at=midnights, labels=days)

dev.off()