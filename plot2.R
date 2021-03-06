

# Store the column names of the Household Power Data in a vector.
names_vect=c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
             "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")       

# Read the data for the rows corresponding to the two required days into a dataframe.
power_data<-read.table("household_power_consumption.txt",col.names=names_vect,sep=";",
                       na.strings="?",skip=66637,nrows=2880)

# Convert the Date column of the data frame from the 'Factor' datatype to 'Date' datatype
power_data[,"Date"]<-as.Date(power_data[,"Date"],format='%d/%m/%Y')


#Paste the columns for Date and Time to form a separate "DateTime" column. 
#Covert this "DateTime" from the "Character" datatype to the "POSIXct" datatype.   
cols <- c("Date","Time")
power_data$DateTime <- apply( power_data[ , cols ] , 1 , paste , collapse = " " )
power_data[,"DateTime"]<-as.POSIXct(strptime(power_data[,"DateTime"],format="%Y-%m-%d %H:%M:%S"))

#Set the graphical parameter for 1 row and 1 column
par(mfrow=c(1,1))

#Open png device. Create a file "plot2.png" in the working directory
png(filename = "plot2.png",
    width = 480, height = 480, 
    bg = "transparent")

# Construct a line plot of Global_active_power v/s DateTime
plot(power_data$DateTime,power_data$Global_active_power,type="l",ylab="Global Active Power(kilowatts)",xlab="")

# Close the png Device
dev.off()