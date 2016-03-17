# Individual household electric power consumption Data Set 
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

# Download code:
if(!file.exists("./data")){
        print("Directory not found.  Creating Data Directory")
        dir.create("./data")}
if(!file.exists("./data/HPC.txt")){
        print("Data file not found.  Downloading File...")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,destfile = "./data/HPC.zip")
        unzip("./data/HPC.zip",exdir = "./data")
        file.rename("./data/household_power_consumption.txt","./data/HPC.txt")
        file.remove("./data/HPC.zip") }

if(!exists("HPC")){
        print("Reading Household Power Consumption file into R...")
        n1 <-read.table("./data/HPC.txt",sep=";",header = TRUE,nrows=1, stringsAsFactors=FALSE)
        HPC <-read.table("./data/HPC.txt",sep = ";",stringsAsFactors=FALSE, na.strings = "?",skip=grep("1/2/2007", readLines("./data/HPC.txt"))[[1]],nrows=2880)
        names(HPC)<-names(n1)
        rm(n1)        }

HPC[,1] <- as.Date(HPC[,1],"%d/%m/%Y")

# Line Plot

png(file="plot3.png",width = 480, height = 480)
plot(strptime(paste(HPC[,1],HPC[,2]), "%Y-%m-%d %H:%M:%S"), HPC$Sub_metering_1, xlab="",ylab="Energy sub metering",type="l")
lines(strptime(paste(HPC[,1],HPC[,2]), "%Y-%m-%d %H:%M:%S"), HPC$Sub_metering_2, col="red")
lines(strptime(paste(HPC[,1],HPC[,2]), "%Y-%m-%d %H:%M:%S"), HPC$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red", "blue"),lty=c(1,1,1))
dev.off()
