Skip to content
Search or jump to…

Pull requests
Issues
Marketplace
Explore

@setarehbehzadi 
Learn Git and GitHub without any code!
  Using the Hello World guide, you’ll start a branch, write comments, and open a pull request.


lpagalan
/
  coursera-exploratory-data-analysis-01
forked from rdpeng/ExData_Plotting1
1
054.6k
Code
Pull requests
Actions
Projects
Wiki
Security
Insights
coursera-exploratory-data-analysis-01/plot2.R
@lpagalan
lpagalan Added white background to graphics
Latest commit cd5882e on Jun 14, 2018
History
1 contributor
58 lines (40 sloc)  1.78 KB


# Load Libraries ----------------------------------------------------------

library(tidyverse)
library(lubridate)

# Load Data ---------------------------------------------------------------

# Create data directory

if(!dir.exists("data")) { dir.create("data") }

# Download and unzip data file

file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

# Load data from 2007-02-01 to 2007-02-02

data <- read_delim("data/household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

# Combine date and time

data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))

# Make Plot ---------------------------------------------------------------

plot(Global_active_power ~ datetime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

# Save Plot ---------------------------------------------------------------

dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

dev.off()

rm(list = ls())

