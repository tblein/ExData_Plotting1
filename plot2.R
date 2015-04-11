# Plot the variation of Global Active Power along time
library(magrittr)
library(dplyr)
library(tidyr)
library(lubridate)

# Number of entries in 2006 and 1007
entry_number_2006 = 21996
entry_number_2007 = 525600

# Read on ly 2006 and 2007 data directrly from the zip file
HPC_data <- read.table("household_power_consumption.txt",
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
png("plot2.png")
    with(HPC_selected,
         plot(datetime, Global_active_power,
              type="l",
              ylab="Global Active Power (kilowatts)",
              xlab="", main=""))
dev.off()
