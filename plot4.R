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

### Create plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(hpc2, {
  plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(DateTime, Voltage, type = "l", xlab = "datetime")
  plot(DateTime,Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
      lines(hpc2$DateTime, hpc2$Sub_metering_2, type="l", col="red")
      lines(hpc2$DateTime, hpc2$Sub_metering_3, type="l", col="blue")
      legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2, 
            col = c("black","red", "blue"), cex = 0.15)
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

### END