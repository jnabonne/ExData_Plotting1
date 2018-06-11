# Reads data file
md <- read.csv("household_power_consumption.txt", sep=";", na.strings='?', colClasses=c(rep("character", 2), rep("numeric", 7)))

## IN CASE OF LACK OF RAM: uses SQL to retrieve only rows between 2007-02-01 and 2007-02-02
#library(sqldf) ; mdl <- read.csv.sql("household_power_consumption.txt", "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'", sep=";")

# Keep only rows from 2007/02/01 to 2007/02/02
md <- md[md$Date=="1/2/2007" | md$Date=="2/2/2007",]

# Create new column DateTime with correct class from cols Date and Time
md$DateTime <- strptime(paste(md$Date, md$Time), "%d/%m/%Y %H:%M:%S", tz="UTC")

# Open PNG File Device
png(file="plot2.png", bg="transparent", width=480, height=480)

# Construct plot
plot(md$DateTime, md$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Close PNG File Device
cat("plot saved to png into ", getwd())
dev.off()
