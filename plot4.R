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



# Create plot: a 2 by 2 panel plot with line graphs on different variables, all over time
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

par(mfrow=c(2,2))

# plot 1

plot(hpc_sub$DateTime,hpc_sub$Global_active_power,type="l", xlab="",ylab="Global Active Power (kilowatts)", main="Global Active Power")

# plot 2

plot(hpc_sub$DateTime,hpc_sub$Voltage,type="l", xlab="datetime",ylab="Voltage")

# plot 3

plot(hpc_sub$DateTime,hpc_sub$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(hpc_sub$DateTime,hpc_sub$Sub_metering_2, type="l", col="red")
lines(hpc_sub$DateTime,hpc_sub$Sub_metering_3, type="l", col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot 4

plot(hpc_sub$DateTime,hpc_sub$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")


dev.copy(png,file="plot4.png", height=480, width=480)

dev.off()
