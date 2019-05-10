library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

## Plot 4
par(mfrow=c(2,2))

plot(x = powerDT[, dateTime], y = powerDT[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(x = powerDT[, dateTime], y = powerDT[, Voltage],col="black",
     type="l", xlab="datetime", ylab="Voltage")

plot(x = powerDT[, dateTime], y = powerDT[, Sub_metering_1],col="black",
      type="l", xlab="", ylab="Energy sub metering")

lines(x = powerDT[, dateTime], y = powerDT[, Sub_metering_2],col="red")

lines(x = powerDT[, dateTime], y = powerDT[, Sub_metering_3],col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red","blue"), lty=1, cex=0.9,box.lty=0)

plot(x = powerDT[, dateTime], y = powerDT[, Global_reactive_power], 
     type="l", xlab="datetime", ylab="Global_rective_power")

dev.off()
