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

#Second Plot
plot(power_consump$Date_Time,power_consump$Global_active_power,type = "l",
     xlab = "",ylab = "Global Active Power(kilowatts)")

png("plot2.png", width=480, height=480)









