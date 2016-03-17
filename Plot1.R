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
        print("Reading Household Power Consumption file")
        n1 <-read.table("./data/HPC.txt",sep=";",header = TRUE,nrows=1,stringsAsFactors=FALSE)
        HPC <-read.table("./data/HPC.txt",sep = ";",stringsAsFactors=FALSE, na.strings = "?",skip=grep("1/2/2007", readLines("./data/HPC.txt"))[[1]],nrows=2880)
        names(HPC)<-names(n1)
        rm(n1)        }

HPC[,1] <- as.Date(HPC[,1],"%d/%m/%Y")

# Histogram
png(file="plot1.png",width = 480, height = 480)
hist(HPC$Global_active_power,col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

