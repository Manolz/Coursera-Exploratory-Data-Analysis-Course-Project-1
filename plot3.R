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

#Third Plot
with(power_consump, plot(Sub_metering_1 ~ Date_Time, type="l", xlab= "", ylab="Energy sub metering"))
lines(power_consump$Sub_metering_2 ~ power_consump$Date_Time, col = 'Red')
lines(power_consump$Sub_metering_3 ~ power_consump$Date_Time, col = 'Blue')
legend("topright", lty=1, lwd =3, col=c("black","red","blue") ,cex = 0.8,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

png("plot3.png", width=480, height=480)
dev.off()