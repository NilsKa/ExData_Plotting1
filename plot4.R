###################################
# Plot 4 - householdData
###################################

## Set working directory and read in data
setwd("C:/Users/Administrator/Documents/R/householdData")

data <- read.csv(file = "household_power_consumption.txt", 
                 header = TRUE, sep = ";")

## Subset data to relevant data and set date/time vectors to POSIXlt
plot_data <- subset(data, Date == "1/2/2007" |
                          Date == "2/2/2007")

plot_data$DateTime <- strptime(paste(plot_data$Date, plot_data$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

plot_data$Date <- NULL
plot_data$Time <- NULL

## Transform vector types of plot_data
plot_data[plot_data == "?"] <- NA

for(i in 1:6)     {
      plot_data[, i] <- as.numeric(as.character(plot_data[[i]]))
}

## Now creating the plot

# Plot 4
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
with(plot_data, plot(DateTime, Global_active_power, 
                     type = "l", ylab = "Global Active Power (kilowatts)",
                     main = "", xlab = ""))
with(plot_data, plot(DateTime, Voltage, type = "l",
                     xlab = "datetime", ylab = "Voltage"))
with(plot_data, plot(DateTime, Sub_metering_1, type = "l", 
                     ylab = "Energy sub metering", xlab = ""))
with(plot_data, lines(DateTime, Sub_metering_2, col = "red"))
with(plot_data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), bty = "n")
with(plot_data, plot(DateTime, Global_reactive_power, type = "l",
                     xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
