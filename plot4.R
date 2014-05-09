

# Store the column names of the Household Power Data in a vector.
names_vect=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")       

# Read the data for the rows corresponding to the two required days into a dataframe.
power_data<-read.table("household_power_consumption.txt",col.names=names_vect,sep=";",na.strings="?",skip=66637,nrows=2880)

# Convert the Date column of the data frame from the 'Factor' datatype to 'Date' datatype
power_data[,"Date"]<-as.Date(power_data[,"Date"],format='%d/%m/%Y')


# Paste the columns for Date and Time to form a separate "DateTime" column. 
# Covert this "DateTime" from the "Character" datatype to the "POSIXct" datatype.
cols <- c("Date","Time")
power_data$DateTime <- apply( power_data[ , cols ] , 1 , paste , collapse = " " )
power_data[,"DateTime"]<-as.POSIXct(strptime(power_data[,"DateTime"],format="%Y-%m-%d %H:%M:%S"))

# Open png device. Create a file "plot4.png" in the working directory
png(filename = "plot4.png",
    width = 480, height = 480, 
    bg = "transparent")

# Set the graphical parameter for 2 rows and 2 columns and adjust the margin widhts
par(mfrow=c(2,2),mar=c(4,4,4,4))

# Set the color as "black" and construct a line plot of Global_active_power v/s DateTime
par(col="black")
plot(power_data$DateTime,power_data$Global_active_power,type="l",ylab="Global Active Power",xlab="")

#construct a line plot of Voltage v/s DateTime
plot(power_data$DateTime,power_data$Voltage,type="l",ylab="Voltage",xlab="datetime")

# Set the appropriate colors and construct a line plot of Sub_metering_1,Sub_metering_2 & Sub_metering_3 v/s DateTime.
# Also construct a legend.
par(col="black")
plot(power_data$DateTime,power_data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
par(col="red")
lines(power_data$DateTime,power_data$Sub_metering_2)
par(col="blue")
lines(power_data$DateTime,power_data$Sub_metering_3)
par(col="black")
legend("topright",bty="n", cex=0.8,col = c("black","red", "blue"), lty=c(1,1,1),legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Set the color as "black" and construct a line plot of Global_reactive_power v/s DateTime
par(col="black")
plot(power_data$DateTime,power_data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.off()
