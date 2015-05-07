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

#open the PNG graphics device
png(file="./plot1.png", width=480, height=480)

# Create a histogram over Global Active Power
hist(s$Global_active_power, col="Red", main="Global Active Power", xlab = "Global Active Power (kilowats)")

# Close the graphics device
dev.off()


