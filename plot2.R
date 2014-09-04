
# file: plot2.R
# path: $HOME/School/Coursera/DataScience_JohnsHopkins/04_ExploratoryDataAnalysis/Project
# author: ???? ?. ?????
# log:
#   2014-09-04  First version

# Libraries:
# (Use 'xts' & 'zoo' for date handle capabilities.)
suppressPackageStartupMessages(library(xts))

# Read in data:
# (Assume data is located in directory & is unzipped.)
filename <- "household_power_consumption.txt"
all.data <- read.table(file=filename, header=TRUE, sep=";", 
                       stringsAsFactor=FALSE, na.strings="?")

# Create 'zoo' object:
timestamps <- as.POSIXct(paste(all.data$Date, all.data$Time), 
                         format="%d/%m/%Y %H:%M:%OS")
HPC <- xts(all.data[, 3:9], timestamps)

# Subset for the days '2007-02-01' & '2007-02-02':
t.start <- "2007-02-01"
t.end   <- "2007-02-02"
t.range <- paste0(t.start, "::", t.end)
HPC.sub <- HPC[t.range]

# Set up the x-axis:
times <- time(HPC.sub)
ticks <- seq(times[1], times[length(times)], length.out=3)
day.names <- round(seq(times[1], times[length(times)], length.out=3), "hours")
fmt <- "%a"  # format for axis labels ("Day Names")
labs <- format(day.names, fmt)

# If conditional is TRUE, plot graph to window system, else plot to file:
if (FALSE) {
  # Create the graph in the 'base' package:
  plot.xts(HPC.sub$Global_active_power, auto.grid=FALSE, xaxt="n", 
           ylab="Global Active Power (kilowatts)", main="")
  axis(1, at=ticks, labels=labs, tcl=-0.5)
} else {
  # Create the 'png' file:
  png(filename="plot2.png")
  plot.xts(HPC.sub$Global_active_power, auto.grid=FALSE, xaxt="n", 
           ylab="Global Active Power (kilowatts)", main="")
  axis(1, at=ticks, labels=labs, tcl=-0.5)
  dev.off()
}
