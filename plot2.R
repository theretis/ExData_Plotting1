#Exploratory Data Analysis
#create a line plot of Global Active Power and save to png
#plot2

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
png("plot2.png")

# create line plot
plot(x = hpc.ss$DateTime, y = hpc.ss$Global_active_power, main = '', type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# save png to file
dev.off()