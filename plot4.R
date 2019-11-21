rm(list = ls())
library(tidyverse)
library(dplyr)
library(lubridate)

# Unzip dataSet to /data directory
unzip(zipfile="C:/Users/hey09895/Desktop/Data Science Specialization/Exploratory Data Analysis/exdata_data_household_power_consumption.zip",
      exdir="C:/Users/hey09895/Desktop/Data Science Specialization/Exploratory Data Analysis")

list.files("C:/Users/hey09895/Desktop/Data Science Specialization/Exploratory Data Analysis")

pathdata<-file.path("C:/Users/hey09895/Desktop/Data Science Specialization/Exploratory Data Analysis")

#list of unzipped files
sep_files<-list.files(pathdata,recursive = TRUE)

power_consump<-read.table(file.path(pathdata,"household_power_consumption.txt"),
                          sep = ";",header = TRUE,na.strings = "?")

power_consump$Date_Time <- with(power_consump, dmy(Date) + hms(Time))
power_consump$Date_Time <- as.POSIXct(power_consump$Date_Time)

power_consump<-power_consump%>%
  select(Date_Time,everything())

power_consump<-power_consump%>%
  select(-c(Date,Time))%>%
  filter(Date_Time >= as.POSIXct("2007-02-01 00:00:00",tz = "GMT") &
           Date_Time <= as.POSIXct("2007-02-02 23:59:00",tz = "GMT"))

power_consump[power_consump == "?"]<-NA

#Fourth Plot
par(mfrow=c(2,2))

with(power_consump,plot(Global_active_power~Date_Time,type = "l",
                        xlab="",ylab = "Global  Active Power"))

plot(power_consump$Voltage ~ power_consump$Date_Time, type="l",
     xlab = "datetime",ylab = "Voltage")

with(power_consump, plot(Sub_metering_1 ~ Date_Time, type="l",
                         xlab="",ylab = "Energy sub metering"))

lines(power_consump$Sub_metering_2 ~ power_consump$Date_Time, col = 'Red')
lines(power_consump$Sub_metering_3 ~ power_consump$Date_Time, col = 'Blue')
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"),cex=0.5)


plot(power_consump$Global_reactive_power ~ power_consump$Date_Time, type="l",
     xlab = "datetime",ylab = "Global_reactive_power")




