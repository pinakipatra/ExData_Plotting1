### Download the file from the required location and unzip it

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./power_consumption.zip")
unzip(zipfile="./power_consumption.zip",exdir=".")

### Read the file into a data frame and verify the no. of records and variables that matches as given

power_consumption_data<-read.csv("household_power_consumption.txt",sep=";",header=TRUE)
dim(power_consumption_data)

### Convert the Factor variable to Date Variable using as.Date() function

power_consumption_data$Date<-as.Date(power_consumption_data$Date,"%d/%m/%Y")

### Filter the dataset only for 2 days that is 1st Febuary 2007 and 2nd February 2007 and count the no. of records and variables

Power_consumption_filtered_data<-power_consumption_data[power_consumption_data$Date>="2007-02-01" & power_consumption_data$Date<="2007-02-02",]
dim(Power_consumption_filtered_data)

### Create a Combined DatTime factor Variable by combining Date and Time

Power_consumption_filtered_data$DateTime<-paste(as.character(Power_consumption_filtered_data$Date),as.character(Power_consumption_filtered_data$Time))

### Covert the Datetime factor variable to Date Variable using strptime function

Power_consumption_filtered_data$DateTime<-strptime(Power_consumption_filtered_data$DateTime,format="%Y-%m-%d %H:%M:%S")

### Remove the Record with ? values in Global_active_power variable

Power_consumption_filtered_data<-Power_consumption_filtered_data[Power_consumption_filtered_data$Global_active_power !="?",]

### Covert the Global_active_power factor variable values to Numeric

Power_consumption_filtered_data$Global_active_power<-as.numeric(paste(Power_consumption_filtered_data$Global_active_power))

### specify the png file where the plots will be drawn

png(filename = "plot2.png",width = 480, height = 480, units = "px")

### draw the plot 

plot(Power_consumption_filtered_data$DateTime,Power_consumption_filtered_data$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()

