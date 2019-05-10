rm(list=ls())

library("dplyr")
library(lubridate)
library(chron)

beginDate<-as.Date("2007-02-01",format="%Y-%m-%d" )
endDate<-as.Date("2007-02-02", format = "%Y-%m-%d" )


setwd("C:/Users/User/Desktop/coursera/course4week1")

name_column<-c("date","time","global_active_power","global_reactive_power",
               "voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3")

mytable<- read.table("household_power_consumption.txt", sep = ';',
                        
                        dec = ".",
                        
                        na.strings = "?")


names(mytable)<-name_column


mytable$date <- as.Date(mytable$date, format= "%d/%m/%Y") 
mytable$date <- as.Date(mytable$date,format= "%y/%m/%d")
mytable$time<-times(chartr(".", ":",mytable$time))

date_to_extract_plot<-filter(mytable,date>=beginDate & date<=endDate)

date_to_extract_plot<-mutate_if(date_to_extract_plot, is.factor, ~ as.numeric(levels(.x))[.x])

png(filename = "plot1.png",
    width = 480, height = 480)

hist(date_to_extract_plot$global_active_power,main="Global Active Power",
     col="red",xlab="Global Active Power (kilowatts)")

dev.off()

