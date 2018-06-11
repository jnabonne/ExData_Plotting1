# Reads data file
md <- read.csv("household_power_consumption.txt", sep=";", na.strings='?', colClasses=c(rep("character", 2), rep("numeric", 7)))

## IN CASE OF LACK OF RAM: uses SQL to retrieve only rows between 2007-02-01 and 2007-02-02
#library(sqldf) ; mdl <- read.csv.sql("household_power_consumption.txt", "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'", sep=";")

# Keep only rows from 2007/02/01 to 2007/02/02
md <- md[md$Date=="1/2/2007" | md$Date=="2/2/2007",]

# Create new column DateTime with correct class from cols Date and Time
md$DateTime <- strptime(paste(md$Date, md$Time), "%d/%m/%Y %H:%M:%S", tz="UTC")

# Open PNG File Device
png(file="plot4.png", bg="transparent", width=480, height=480)

# Change display to 2x2 plots, remove top-margin
par(mfrow=c(2,2), mar=(c(5.1, 4.1, 4.1, 2.1)))  # default mar 5.1 4.1 4.1 2.1

# Contruct 1st plot (top-left)
plot(md$DateTime, md$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Contruct 2nd plot (top-right)
plot(md$DateTime, md$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Contruct 3rd plot (bottom-left)
plot( md$DateTime, md$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(md$DateTime, md$Sub_metering_2, type="l", col="red")
lines(md$DateTime, md$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=1, bty = "n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Contruct 4th plot (bottom-right)
plot(md$DateTime, md$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close PNG File Device
cat("plot saved to png into ", getwd())
dev.off()
