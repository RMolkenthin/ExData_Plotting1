## Plot 4: 2x2 diagrams
## libraries and files and locale for English output in particular Posixt
library(datasets)
Sys.setlocale(locale = "english")
file = "household_power_consumption.txt"


## Read data only for 2007-02-01 -> 02-02 
l <- readLines(file)
s <- head(grep('^[12]{1}/2/2007', l), 1)-1
e <- tail(grep('^[12]{1}/2/2007', l), 1)
remove(l)


header <- read.table(file, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
consumption <- read.table(file, header = TRUE, sep = ";", na.strings = "?", 
                          stringsAsFactors = FALSE, skip = s-1, nrows = (e-s))
colnames(consumption) <- unlist(header)

## Date coercion
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")


## Plot first on screen device
## x-axis time
t <- strptime(paste(consumption$Date, consumption$Time), format = "%Y-%m-%d %H:%M:%S")
par(ps = 10, mfrow = c(2,2), mar = c(4,4,2,2))

## Plot 1
plot(t, consumption$Global_active_power, type = "n", main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(t, consumption$Global_active_power)

## Plot 2
plot(t, consumption$Voltage, type = "n", main = "", xlab = "datetime", ylab = "Voltage")
lines(t, consumption$Voltage)


## Plot 3
plot(rep(t,3), c(consumption$Sub_metering_1, consumption$Sub_metering_2, consumption$Sub_metering_3), type ="n", main = "", xlab = "", ylab = "Energy sub metering")
lines(t, consumption$Sub_metering_1, col = "black")
lines(t, consumption$Sub_metering_2, col = "red")
lines(t, consumption$Sub_metering_3, col = "blue")
legend("topright",lty = 1, bty = "n", col = c("black", "red", "blue"), legend = names(consumption)[7:9])

## Plot 4
plot(t, consumption$Global_reactive_power, type = "n", main = "", xlab = "datetime", ylab = "Global_reactive_power")
lines(t, consumption$Global_reactive_power)

## Save as PNG
## copy to screen device to png device
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()