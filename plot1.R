# plot1.R ------------------------------------- #


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

## Create histogram for global active power
png(file="plot1.png", height=480, width=480)
hist(use_dat$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     yaxt = "n"
    )  
axis(side=2, at=seq(0, 1200, 200), labels=seq(0, 1200, 200), cex.axis=.75)
dev.off()
