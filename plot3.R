# Reads data file
md <- read.csv("household_power_consumption.txt", sep=";", na.strings='?', colClasses=c(rep("character", 2), rep("numeric", 7)))

## IN CASE OF LACK OF RAM: uses SQL to retrieve only rows between 2007-02-01 and 2007-02-02
#library(sqldf) ; mdl <- read.csv.sql("household_power_consumption.txt", "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'", sep=";")

# Keep only rows from 2007/02/01 to 2007/02/02
md <- md[md$Date=="1/2/2007" | md$Date=="2/2/2007",]

# Create new column DateTime with correct class from cols Date and Time
md$DateTime <- strptime(paste(md$Date, md$Time), "%d/%m/%Y %H:%M:%S", tz="UTC")

# Open PNG File Device
png(file="plot3.png", bg="transparent", width=480, height=480)

# Construct plot
plot( md$DateTime, md$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(md$DateTime, md$Sub_metering_2, type="l", col="red")
lines(md$DateTime, md$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close PNG File Device
cat("plot saved to png into ", getwd())
dev.off()
