# Load Data

getwd()
setwd(("C:/Users/1412053/Desktop/Lecture4_W1"))
unzip(zipfile="./exdata_data_household_power_consumption.zip")
raw <-read.table("household_power_consumption.txt", sep=";", header=TRUE, 
                   colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
TimeDate <- strptime(paste(raw$Date, raw$Time), "%d/%m/%Y %H:%M:%S")
raw <-cbind(TimeDate, raw)
raw$Date <- as.Date(raw$Date, "%d/%m/%Y")
dates <- as.Date (c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
df <- subset(raw, Date %in% dates)
df <-df[, c(-2, -3)]
df <-df[complete.cases(df),]


#Plot 1

hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()
dev.cur()

#Plot 2
Sys.setlocale("LC_ALL", "English")
plot(df$Global_active_power~df$TimeDate, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
dev.cur()



#Plot 3
with(df, {plot(Sub_metering_1~TimeDate, type="l", ylab="Global Active Power (kilowatts)", xlab="")
          lines(Sub_metering_2~TimeDate, col="red")
          lines(Sub_metering_3~TimeDate, col="blue")})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "plot3.png", width=580, height=480)
dev.off()
dev.cur()

#Plot 4
par(mfrow=c(2,2), mar=c(4, 4, 2, 1))
with(df, {
  plot(Global_active_power~TimeDate, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(Voltage~TimeDate, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~TimeDate, type="l", ylab="Global Active Power(Kilowatts)", xlab="")
  lines(Sub_metering_2~TimeDate, col="red")
  lines(Sub_metering_3~TimeDate, col="blue")
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~TimeDate, type="l", ylab="Global Reactive Power (kilowatts)", xlab="")
  
})
dev.copy(png, "plot4.png", width=580, height=480)
dev.off()
dev.cur()






