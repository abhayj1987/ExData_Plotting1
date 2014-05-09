

# Store the column names of the Household Power Data in a vector.
names_vect=c("Date","Time","Global_active_power","Global_reactive_power",
             "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")       

# Read the data for the rows corresponding to the two required days into a dataframe.
power_data<-read.table("household_power_consumption.txt",col.names=names_vect,sep=";",na.strings="?",skip=66637,nrows=2880)

# Convert the Date column of the data frame from the 'Factor' datatype to 'Date' datatype
power_data[,"Date"]<-as.Date(power_data[,"Date"],format='%d/%m/%Y')

#Construct a histogram of the coulmn "Global_active_power"
hist(power_data$Global_active_power,main="Global Active Power",col="red",
     xlab="Global Active Power(kilowatts)",ylab="Frequency")

#Set the graphical parameter for 1 row and 1 column
par(mfrow=c(1,1))

#Open png device. Create a file "plot1.png" in the working directory
png(filename = "plot1.png",
    width = 480, height = 480, 
    bg = "transparent")

# Construct a histogram of the coulmn "Global_active_power" in the open png file 
hist(power_data$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power(kilowatts)",ylab="Frequency")

# Close the png Device
dev.off()