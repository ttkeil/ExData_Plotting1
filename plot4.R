# plot4.R ------------------------------------- #


## Set working directory
setwd("~/data_science_toolbox/R/ExData_Plotting1")
wd_var <- getwd()

## Download .zip file to specified destination
fileURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
destfile <- paste(wd_var, "/04_proj_01_dat.zip", sep="", collapse="")
download.file(fileURL, destfile = destfile, mode="wb", method="curl")
list.files(wd_var) 

## Unzip file and read tables
unzip(destfile)
list.files() 

## Read table from .txt file
total_dat <- read.table("household_power_consumption.txt",
                        header=TRUE,
                        sep=";", 
                        na.strings="?",
                        stringsAsFactors=FALSE)


str(total_dat)
head(total_dat)

## Only need records for two dates in Feb. 2007
use_dat <- total_dat[total_dat$Date=="1/2/2007" | total_dat$Date=="2/2/2007", ]
str(use_dat)
table(use_dat$Date)

## Delete original dataset
rm(total_dat)


## Convert Date field
use_dat$Date <- as.Date(use_dat$Date, format="%d/%m/%Y")
table(use_dat$Date)
str(use_dat)

## Convert Time field
use_dat$Time <- strptime(paste(use_dat$Date, use_dat$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
str(use_dat)

## Create four charts on one screen
png(file="plot4.png", height=480, width=480)
par(mfrow=c(2,2))

## Create line chart of global active power by time
with(use_dat, plot(Time, Global_active_power,
                   type="n",
                   ylab = "Global Active Power",
                   xlab = ""
                  )
    )
with(use_dat, lines(Time, Global_active_power))

## Create line chart of global active power by time
with(use_dat, plot(Time, Voltage,
                   type="n",
                   ylab = "Voltage",
                   xlab = "datetime"
                  )
      )
with(use_dat, lines(Time, Voltage))

## Create line chart of sub_metering by time
with(use_dat, plot(Time, Sub_metering_1,
                   type="n",
                   ylab = "Energy sub metering",
                   xlab = ""
                   )
    )
with(use_dat, lines(Time, Sub_metering_1))
with(use_dat, lines(Time, Sub_metering_2, col = "red"))
with(use_dat, lines(Time, Sub_metering_3, col = "blue"))
legend( "topright",
        lwd=1,
        col=c("black","red","blue"),
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        bty="n"
      )

## Create line chart of global reactive power by time
with(use_dat, plot(Time, Global_reactive_power,
                   type="n",
                   ylab = "Global_reactive_power",
                   xlab = "datetime"
                   )
    )
with(use_dat, lines(Time, Global_reactive_power))
dev.off()
