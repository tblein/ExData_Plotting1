# Plot the variation of 3 sub metering along time
library(magrittr)
library(dplyr)
library(tidyr)
library(lubridate)

# Number of entries in 2006 and 1007
entry_number_2006 = 21996
entry_number_2007 = 525600

# Read on ly 2006 and 2007 data directrly from the zip file
HPC_data <- read.table("data/household_power_consumption.txt"
                       nrows=entry_number_2006 + entry_number_2007 + 1,
                       header=TRUE, sep=";", na.strings="?")

# Fuse the date and time and format it as time class
HPC_data %<>% unite("datetime", c(Date, Time), sep=" ") %>% 
              mutate(datetime=dmy_hms(datetime))

# Selecte the data between 2007-02-01 and 2007-02-02
HPC_selected <- HPC_data %>% 
                filter(ymd("2007-02-01") <= datetime,
                       datetime < ymd("2007-02-03"))

# Create the plot
png("plot3.png")
    with(HPC_selected,
         {
             plot(datetime, Sub_metering_1,
                  type="l",
                  ylab="Energy sub metering",
                  xlab="", main="")
             lines(datetime, Sub_metering_2, col="red")
             lines(datetime, Sub_metering_3, col="blue")
          })
    legend("topright",
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"),
           lty=1)
dev.off()
