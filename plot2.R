# Purpose of this R script is to create a plot and store this 
# as a separate .PNG file.
# The data source for the plot is the “Individual household electric power
# consumption Data Set”. This set contains data on measurements of electric
# power consumption in one household with a one-minute sampling rate over
# a period of almost 4 years. Different electrical quantities and some
# sub-metering values are available in this set.
# Before running the script ensure that the correct working directory has
# been set that contains the directory with the downloaded dataset

# Read data and prepare into a tidy dataset
# +++++++++++++++++++++++++++++++++++++++++

hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";", na.strings="?")
hpc_sub <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007", ]

# conversion of date and time into new combined DateTime variable in right format 

hpc_sub$Date <- as.Date(hpc_sub$Date,format="%d/%m/%Y")

hpc_sub$DateTime <- strptime(paste(hpc_sub$Date,hpc_sub$Time),format="%Y-%m-%d %H:%M:%S")



# Create plot: a line graph on Global active power over time
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

plot(hpc_sub$DateTime,hpc_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

dev.copy(png,file="plot2.png", height=480, width=480)

dev.off()
