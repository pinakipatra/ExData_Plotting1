### Download the file from the required location and unzip it

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./power_consumption.zip")
unzip(zipfile="./power_consumption.zip",exdir=".")

### Read the file into a data frame and verify the no. of records and variables that matches as given

power_consumption_data<-read.csv("household_power_consumption.txt",sep=";",header=TRUE)
dim(power_consumption_data)

### Convert the Factor variable to Date Variable

power_consumption_data$Date<-as.Date(power_consumption_data$Date,"%d/%m/%Y")

### Filter the dataset only for 2 days that is 1st Febuary 2007 and 2nd February 2007 and count the no. of records and variables

Power_consumption_filtered_data<-power_consumption_data[power_consumption_data$Date>="2007-02-01" & power_consumption_data$Date<="2007-02-02",]
dim(Power_consumption_filtered_data)

### Create a Combined DatTime factor Variable by combining Date and Time

Power_consumption_filtered_data$DateTime<-paste(as.character(Power_consumption_filtered_data$Date),as.character(Power_consumption_filtered_data$Time))


### Covert the Datetime factor variable to Date Variable using strptime function

Power_consumption_filtered_data$DateTime<-strptime(Power_consumption_filtered_data$DateTime,format="%Y-%m-%d %H:%M:%S")

### Remove the Record with ? values in Global_active_power variable or Sub_Metering_1 variable or Sub_Metering_2 variable or Sub_Metering_3 variable

Power_consumption_filtered_data<-Power_consumption_filtered_data[Power_consumption_filtered_data$Global_active_power !="?" | 
Power_consumption_filtered_data$Sub_metering_1 !="?" |
Power_consumption_filtered_data$Sub_metering_2 !="?" |
Power_consumption_filtered_data$Sub_metering_3 !="?" |
Power_consumption_filtered_data$Global_reactive_power !="?" |
Power_consumption_filtered_data$Voltage !="?",]


### Covert the required factor variable values to Numeric

Power_consumption_filtered_data$Global_active_power<-as.numeric(paste(Power_consumption_filtered_data$Global_active_power))
Power_consumption_filtered_data$Sub_metering_1<-as.numeric(paste(Power_consumption_filtered_data$Sub_metering_1))
Power_consumption_filtered_data$Sub_metering_2<-as.numeric(paste(Power_consumption_filtered_data$Sub_metering_2))
Power_consumption_filtered_data$Sub_metering_3<-as.numeric(paste(Power_consumption_filtered_data$Sub_metering_3))
Power_consumption_filtered_data$Voltage<-as.numeric(paste(Power_consumption_filtered_data$Voltage))
Power_consumption_filtered_data$Global_reactive_power<-as.numeric(paste(Power_consumption_filtered_data$Global_reactive_power))


### specify the png file where the plots will be drawn

png(filename = "plot4.png",width = 480, height = 480, units = "px")

### draw the plots and lines

par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(Power_consumption_filtered_data,{
plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Eergy Sub Metering")
lines(DateTime,Sub_metering_2,type="l",xlab="",ylab="Eergy Sub Metering",col="red")
lines(DateTime,Sub_metering_3,type="l",xlab="",ylab="Eergy Sub Metering",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),fill=c("black","red","blue"))
plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
}
)
dev.off()


