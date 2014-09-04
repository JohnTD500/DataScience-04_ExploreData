
# file: plot1.R
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

# If conditional is TRUE, plot graph to window system, else plot to file:
if (FALSE) {
  # Create the graph in the 'base' package:
  hist(HPC.sub$Global_active_power, 
       main="Global Active Power", xlab="Global Active Power", 
       col="Red", border="Black")
} else {
  # Create the 'png' file:
  png(filename="plot1.png")
  hist(HPC.sub$Global_active_power, 
       main="Global Active Power", xlab="Global Active Power", 
       col="Red", border="Black")
  dev.off()
}
