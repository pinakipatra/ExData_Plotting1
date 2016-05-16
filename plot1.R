### Download the file from the required location and unzip it

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./power_consumption.zip")
unzip(zipfile="./power_consumption.zip",exdir=".")

### Read the file into a data frame and verify the no. of records and variables that matches as given

power_consumption_data<-read.csv("household_power_consumption.txt",sep=";",header=TRUE)
dim(power_consumption_data)

### Convert the Factor variable to Date Variable

power_consumption_data$Date<-as.Date(power_consumption_data$Date,"%d/%m/%Y")

### Filter the dataset only for 2 days that is 1st Febuary 2007 and 2nd February 2007 and count the no. of records and variables

Power_consumption_filtered_data<-power_consumption_data[power_consumption_data$Date>="2007-02-01" & power_consumption_data$Date<="2007-02-02",]
dim(Power_consumption_filtered_data)

### Remove the Record with ? values in Global_active_power variable

Power_consumption_filtered_data<-Power_consumption_filtered_data[Power_consumption_filtered_data$Global_active_power !="?",]


### Covert the Global_active_power factor variable values to Numeric

Power_consumption_filtered_data$Global_active_power<-as.numeric(paste(Power_consumption_filtered_data$Global_active_power))

### specify the png file where the plots will be drawn

png(filename = "plot1.png",width = 480, height = 480, units = "px")

### draw the histogram 

hist(Power_consumption_filtered_data$Global_active_power,col="red",xlab="Global Active Power(killowatts)",main="Global Active Power")
dev.off()

