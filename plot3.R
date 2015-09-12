#Exploratory Data Analysis
#create a multiple line plot for of Sub_metering_1, Sub_metering_2, Sub_metering_3 and save to png
#plot3

#load required library
library(dplyr)

# read the text file
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.srings = c("?"))

# using chevrons, get a subset of the required data, and add a DateTime field based on Date and Time fields
hpc.ss <- hpc %>%
	subset(Date == '1/2/2007' | Date == '2/2/2007') %>%
	select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
        mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

# set up for png output
png("plot3.png")

#get range for x and y
xrange <- range(hpc.ss$DateTime)
yrange <- range(hpc.ss$Sub_metering_1, hpc.ss$Sub_metering_2, hpc.ss$Sub_metering_3)

# create line plot
plot(xrange, yrange, type = "n", xlab = "", ylab = "Energy sub metering") 

lines(x = hpc.ss$DateTime, y = hpc.ss$Sub_metering_1, main = '', type = "l", col = "black")
lines(x = hpc.ss$DateTime, y = hpc.ss$Sub_metering_2, main = '', type = "l", col = "red")
lines(x = hpc.ss$DateTime, y = hpc.ss$Sub_metering_3, main = '', type = "l", col = "blue")

#add legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"))

# save png to file
dev.off()