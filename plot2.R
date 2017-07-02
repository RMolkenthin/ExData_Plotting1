## Plot 2: Line diagram Global Active Power
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


## Plot first line-diagram on screen device
## x-axis time
t <- strptime(paste(consumption$Date, consumption$Time), format = "%Y-%m-%d %H:%M:%S")
gap <- consumption$Global_active_power
par(ps = 10)
plot(t, gap, type = "n", main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(t, gap)

## Save as PNG
## copy to screen device to png device
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()