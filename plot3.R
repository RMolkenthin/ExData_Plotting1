## Plot 3: Sub-Meter data
## libraries and files and locale for English output in particular Posixt
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


## Plot first line-diagram on screen device
## x-axis time
t <- strptime(paste(consumption$Date, consumption$Time), format = "%Y-%m-%d %H:%M:%S")
par(ps = 10)
plot(rep(t,3), c(consumption$Sub_metering_1, consumption$Sub_metering_2, consumption$Sub_metering_3), type ="n", main = "", xlab = "", ylab = "Energy sub metering")
lines(t, consumption$Sub_metering_1, col = "black")
lines(t, consumption$Sub_metering_2, col = "red")
lines(t, consumption$Sub_metering_3, col = "blue")
legend("topright",lty = 1, col = c("black", "red", "blue"), legend = names(consumption)[7:9])

## Save as PNG
## copy to screen device to png device
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()