## variables
#1. Date: Date in format dd/mm/yyyy 
#2. Time: time in format hh:mm:ss 
#3. Global_active_power: household global minute-averaged active power (in kilowatt) 
#4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
#5. Voltage: minute-averaged voltage (in volt) 
#6. Global_intensity: household global minute-averaged current intensity (in ampere) 
#7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
#8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. 
#9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Read the source data
# NA is represented as '?'
power <- read.table("./data//household_power_consumption.txt", sep = ";", header=TRUE, na.strings="?", colClasses = c("character","character","numeric",NA,NA,NA,NA,NA,NA))

# Combine the Date & Time columns into a new DateTime column
power <- cbind(DateTime = strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S"), power)

# Fix the type of the Date column
power$Date <- as.Date(power$DateTime)

# We will only be using data from the dates 2007-02-01 and 2007-02-02
s <- subset(power, power$Date == as.Date("2007-02-01") | power$Date == as.Date("2007-02-02"))

# Use US locale
Sys.setlocale("LC_TIME","US")

#open the PNG graphics device
png(file="./plot4.png", width=480, height=480)

# Split the screen into a 2x2 matrix
par(mfrow=c(2,2))

# Global Active Power
plot(s$DateTime, s$Global_active_power, type = "l", ylab="Global Active Power", xlab="")

# Voltage
plot(s$DateTime, s$Voltage, type = "l", ylab="Voltage", xlab="datetime")

# Sub Metering
plot(s$DateTime, s$Sub_metering_1, type = "l", col="black", ylab="Energy sub metering", xlab="")
lines(s$DateTime, s$Sub_metering_2, type = "l", col="red")
lines(s$DateTime, s$Sub_metering_3, type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, bty="n")

# Global reactive power
plot(s$DateTime, s$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime")


# Close the graphics device
dev.off()


