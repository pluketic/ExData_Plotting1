
library(plyr)

# Assign file name to the file object
file <- "household_power_consumption.txt"

# Load the data
Hh_PowerCons <- read.delim(file, header = TRUE, sep = ";", na.strings="?",stringsAsFactors=FALSE, dec=".")

# Format Date column as Date & delete Hh_PowerCons
Hh_PowerCons1 <- mutate(Hh_PowerCons,Date = as.Date(Date, format="%d/%m/%Y"))
rm(Hh_PowerCons)

# Subset the data to the required time frame & delete Hh_PowerCons1
Hh_PowerCons_Dt <- subset(Hh_PowerCons1, Date == "2007-02-01" | Date == "2007-02-02")
rm(Hh_PowerCons1)

## Add Datetime column to the Hh_PowerCons_Dt data frame
datetime <- paste(as.Date(Hh_PowerCons_Dt$Date), Hh_PowerCons_Dt$Time)
Hh_PowerCons_Dt$Datetime <- as.POSIXct(datetime)

# Format Global_active_power & Global_reactive_power columns as numeric
Hh_PowerCons_Dt <- mutate(Hh_PowerCons_Dt,Global_active_power = as.numeric(Global_active_power))
Hh_PowerCons_Dt <- mutate(Hh_PowerCons_Dt,Global_reactive_power = as.numeric(Global_reactive_power))

## Plot 2 to png
png("plot2.png", width=480, height=480)
plot(Hh_PowerCons_Dt$Global_active_power ~ Hh_PowerCons_Dt$Datetime, 
     xlab="", ylab="Global Active Power (kilowatts)", col="Black",type="l")
dev.off()
