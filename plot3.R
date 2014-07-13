## plot3.R

# read in first five lines of data to determine column classes
tmp <- read.table("household_power_consumption_sample.txt", header = TRUE, sep = ";", nrows = 5)
# store class of each column in the variable classes
classes <- sapply(tmp, class)

# read in sampled data from 2007-02-01 and 2007-02-02 and specify column classes
data <- read.table("household_power_consumption_sample.txt", 
                   header = TRUE, 
                   sep=";", 
                   nrows = 2881, 
                   na.strings="?", 
                   colClasses = classes)

# combine Date and Time field to form datetime field
data$datetime <- as.POSIXlt(paste(as.Date(data$Date, format = "%d/%m/%Y"), data$Time, sep = " "))

# write graph as png with a file width of 480 pixels and a height of 480 pixels 
png(filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px")

# construct plot 3: line graph of day of week by global active power (kilowatts) 
plot(data$datetime, 
     data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close file
dev.off()