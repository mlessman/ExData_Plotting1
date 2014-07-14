data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')
names(data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
data$datetime <- strptime(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)


png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power"))

with(data, plot(datetime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))

with(data, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "black"))
lines (data$datetime, data$Sub_metering_2, type = "l", col = "red")
points (data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty="n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

with(data, plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))


dev.off()