#Exploratory Data Analysis
#create a histogram of Global Active Power frequency and save to png
#plot1

#load required library
library(dplyr)

# read the text file
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c("?"))

# using chevrons, get a subset of the required data, and add a DateTime field based on Date and Time fields
hpc.ss <- hpc %>%
	subset(Date == '1/2/2007' | Date == '2/2/2007') %>%
	select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
        mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

# set up for png output
png("plot1.png")

# create histogram
hist(hpc.ss$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# save png to file
dev.off()