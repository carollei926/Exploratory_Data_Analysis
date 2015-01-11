setwd("C:/Users/leip/Desktop/Exploratory Data Analysis/Course_Project_1")
### Read-in data
hpc <- read.table("./household_power_consumption.txt",sep = ";" , header = T, na.strings = "?", dec = ".")

### Subset data
hpc2 <- hpc[which(hpc$Date %in% c("1/2/2007","2/2/2007")), ]

### Data manipulation- change format and create new vars
# make plot variables into numeric
hpc2$Global_active_power <- as.numeric(hpc2$Global_active_power)
hpc2$Sub_metering_1 <- as.numeric(hpc2$Sub_metering_1)
hpc2$Sub_metering_2 <- as.numeric(hpc2$Sub_metering_2)
# Create DateTime var for plotting
DateTime1 <- paste (as.character(hpc2$Date),as.character(hpc2$Time) , sep = " ", collapse = NULL)
hpc2$DateTime <- strptime(DateTime1,'%d/%m/%Y %H:%M:%S')
# Create weekdays
library(lubridate)
hpc2$day <- wday(as.Date(hpc2$DateTime), label=TRUE)

### Create plot 2
plot(hpc2$DateTime,hpc2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

### END