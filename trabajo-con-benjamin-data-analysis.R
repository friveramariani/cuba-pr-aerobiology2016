# set working directory
setwd("C:/Users/Felix/Dropbox/Scientific/Manuscripts/trabajo-con-benjamin")

# load datasets from 2011
jan2011 <- read.csv("201101daily.txt"); feb2011 <- read.csv("201102daily.txt")
march2011 <- read.csv("201103daily.txt"); april2011 <- read.csv("201104daily.txt")
may2011 <- read.csv("201105daily.txt"); june2011 <- read.csv("201106daily.txt")
july2011 <- read.csv("201107daily.txt"); aug2011 <- read.csv("201108daily.txt")
sept2011 <- read.csv("201109daily.txt"); oct2011 <- read.csv("201110daily.txt")
nov2011 <- read.csv("201111daily.txt"); dec2011 <- read.csv("201112daily.txt")

# load datasets from 2012
jan2012 <- read.csv("201201daily.txt"); feb2012 <- read.csv("201202daily.txt")
march2012 <- read.csv("201203daily.txt"); april2012 <- read.csv("201204daily.txt")
may2012 <- read.csv("201205daily.txt"); june2012 <- read.csv("201206daily.txt")
july2012 <- read.csv("201207daily.txt"); aug2012 <- read.csv("201208daily.txt")
sept2012 <- read.csv("201209daily.txt"); oct2012 <- read.csv("201210daily.txt")
nov2012 <- read.csv("201211daily.txt"); dec2012 <- read.csv("201212daily.txt")

# load datasets from 2013
jan2013 <- read.csv("201301daily.txt"); feb2013 <- read.csv("201302daily.txt")
march2013 <- read.csv("201303daily.txt"); april2013 <- read.csv("201304daily.txt")
may2013 <- read.csv("201305daily.txt"); june2013 <- read.csv("201306daily.txt")
july2013 <- read.csv("201307daily.txt"); aug2013 <- read.csv("201308daily.txt")
sept2013 <- read.csv("201309daily.txt"); oct2013 <- read.csv("201310daily.txt")
nov2013 <- read.csv("201311daily.txt"); dec2013 <- read.csv("201312daily.txt")

#subset year 2011 for Puerto Rico station: WBAN 11641
jan2011pr <- subset (jan2011, WBAN == 11641); feb2011pr <- subset (feb2011, WBAN == 11641)
march2011pr <- subset (march2011, WBAN == 11641); april2011pr <- subset (april2011, WBAN == 11641)
may2011pr <- subset (may2011, WBAN == 11641); june2011pr <- subset (june2011, WBAN == 11641)
july2011pr <- subset (july2011, WBAN == 11641); aug2011pr <- subset (aug2011, WBAN == 11641)
sept2011pr <- subset (sept2011, WBAN == 11641); oct2011pr <- subset (oct2011, WBAN == 11641)
nov2011pr <- subset (nov2011, WBAN == 11641); dec2011pr <- subset (dec2011, WBAN == 11641)

#subset year 2012 for Puerto Rico station: WBAN 11641
jan2012pr <- subset (jan2012, WBAN == 11641); feb2012pr <- subset (feb2012, WBAN == 11641)
march2012pr <- subset (march2012, WBAN == 11641); april2012pr <- subset (april2012, WBAN == 11641)
may2012pr <- subset (may2012, WBAN == 11641); june2012pr <- subset (june2012, WBAN == 11641)
july2012pr <- subset (july2012, WBAN == 11641); aug2012pr <- subset (aug2012, WBAN == 11641)
sept2012pr <- subset (sept2012, WBAN == 11641); oct2012pr <- subset (oct2012, WBAN == 11641)
nov2012pr <- subset (nov2012, WBAN == 11641); dec2012pr <- subset (dec2012, WBAN == 11641)

#subset year 2013 for Puerto Rico station: WBAN 11641
jan2013pr <- subset (jan2013, WBAN == 11641); feb2013pr <- subset (feb2013, WBAN == 11641)
march2013pr <- subset (march2013, WBAN == 11641); april2013pr <- subset (april2013, WBAN == 11641)
may2013pr <- subset (may2013, WBAN == 11641); june2013pr <- subset (june2013, WBAN == 11641)
july2013pr <- subset (july2013, WBAN == 11641); aug2013pr <- subset (aug2013, WBAN == 11641)
sept2013pr <- subset (sept2013, WBAN == 11641); oct2013pr <- subset (oct2013, WBAN == 11641)
nov2013pr <- subset (nov2013, WBAN == 11641); dec2013pr <- subset (dec2013, WBAN == 11641)

# rowbind datasets by year, then all three years
pr2011 <- rbind (jan2011pr, feb2011pr, march2011pr, april2011pr, may2011pr, june2011pr, july2011pr, aug2011pr, sept2011pr, oct2011pr, nov2011pr, dec2011pr)

pr2012 <- rbind (jan2012pr, feb2012pr, march2012pr, april2012pr, may2012pr, june2012pr, july2012pr, aug2012pr, sept2012pr, oct2012pr, nov2012pr, dec2012pr)

pr2013 <- rbind (jan2013pr, feb2013pr, march2013pr, april2013pr, may2013pr, june2013pr, july2013pr, aug2013pr, sept2013pr, oct2013pr, nov2013pr, dec2013pr)

prclimatedata <- rbind (pr2011, pr2012, pr2013)

# confirm that all data corresponds to station 11641
summary (prclimatedata$WBAN)

# select for Temperature (Tmin, Tmax, Tavg, WetBulb, Dewpoint)

library (plyr); library (dplyr)

prclimateshort <- select (prclimatedata, WBAN, YearMonthDay, Tmax, Tmin, Tavg, WetBulb, PrecipTotal, Sunrise, Sunset)

# change all variables as numeric excelt WBAN and YearMonthDay

prclimateshort$Tmax <- as.numeric(as.character(prclimateshort$Tmax)); prclimateshort$Tmin <- as.numeric(as.character(prclimateshort$Tmin))
prclimateshort$Tavg <- as.numeric(as.character(prclimateshort$Tavg)); prclimateshort$WetBulb <- as.numeric(as.character(prclimateshort$WetBulb))
prclimateshort$PrecipTotal <- as.numeric(as.character(prclimateshort$PrecipTotal))
# change WBAN to factor; YearMonthDay as Date

library (lubridate)
prclimateshort$YearMonthDay <- ymd(as.character(prclimateshort$YearMonthDay))

prclimateshort$WBAN <- as.factor (prclimateshort$WBAN)

# change Sunrise and Sunset from integer to time
prclimateshort$Sunset <- format(strptime(prclimateshort$Sunset, format="%H%M"), format = "%H:%M")

prclimateshort$Sunrise <- format(strptime(prclimateshort$Sunrise, format="%H%M"), format = "%H:%M")

#obtain relative humidity information
##1) load houly information rather than daily information for year 2011
library (data.table)
jan2011h <- fread("201101hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
feb2011h <- fread("201102hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
march2011h <- fread("201103hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
april2011h <- fread("201104hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
may2011h <- fread("201105hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
june2011h <- fread("201106hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
july2011h <- fread("201107hourly.txt", select = c("WBAN", "Date", "RelativeHumidity")) 
aug2011h <- fread("201108hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
sept2011h <- fread("201109hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
oct2011h <- fread("201110hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
nov2011h <- fread("201111hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
dec2011h <- fread("201112hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))

##2) load houly information rather than daily information for year 2012
jan2012h <- fread("201201hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
feb2012h <- fread("201202hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
march2012h <- fread("201203hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
april2012h <- fread("201204hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
may2012h <- fread("201205hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
june2012h <- fread("201206hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
july2012h <- fread("201207hourly.txt", select = c("WBAN", "Date", "RelativeHumidity")) 
aug2012h <- fread("201208hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
sept2012h <- fread("201209hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
oct2012h <- fread("201210hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
nov2012h <- fread("201211hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
dec2012h <- fread("201212hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))


## load houly information rather than daily information for year 2013
jan2013h <- fread("201301hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
feb2013h <- fread("201302hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
march2013h <- fread("201303hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
april2013h <- fread("201304hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
may2013h <- fread("201305hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
june2013h <- fread("201306hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
july2013h <- fread("201307hourly.txt", select = c("WBAN", "Date", "RelativeHumidity")) 
aug2013h <- fread("201308hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
sept2013h <- fread("201309hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
oct2013h <- fread("201310hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
nov2013h <- fread("201311hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))
dec2013h <- fread("201312hourly.txt", select = c("WBAN", "Date", "RelativeHumidity"))


## subset hourly information within the year 2011 for Puerto Rico station: WBAN 11641
jan2011prh <- subset (jan2011h, WBAN == 11641); feb2011prh <- subset (feb2011h, WBAN == 11641)
march2011prh <- subset (march2011h, WBAN == 11641); april2011prh <- subset (april2011h, WBAN == 11641)
may2011prh <- subset (may2011h, WBAN == 11641); june2011prh <- subset (june2011h, WBAN == 11641)
july2011prh <- subset (july2011h, WBAN == 11641); aug2011prh <- subset (aug2011h, WBAN == 11641)
sept2011prh <- subset (sept2011h, WBAN == 11641); oct2011prh <- subset (oct2011h, WBAN == 11641)
nov2011prh <- subset (nov2011h, WBAN == 11641); dec2011prh <- subset (dec2011h, WBAN == 11641)

## subset hourly information within the year 2012 for Puerto Rico station: WBAN 11641
jan2012prh <- subset (jan2012h, WBAN == 11641); feb2012prh <- subset (feb2012h, WBAN == 11641)
march2012prh <- subset (march2012h, WBAN == 11641); april2012prh <- subset (april2012h, WBAN == 11641)
may2012prh <- subset (may2012h, WBAN == 11641); june2012prh <- subset (june2012h, WBAN == 11641)
july2012prh <- subset (july2012h, WBAN == 11641); aug2012prh<- subset (aug2012h, WBAN == 11641)
sept2012prh <- subset (sept2012h, WBAN == 11641); oct2012prh <- subset (oct2012h, WBAN == 11641)
nov2012prh<- subset (nov2012h, WBAN == 11641); dec2012prh <- subset (dec2012h, WBAN == 11641)

## subset hourly information within the year 2013 for Puerto Rico station: WBAN 11641
jan2013prh <- subset (jan2013h, WBAN == 11641); feb2013prh <- subset (feb2013h, WBAN == 11641)
march2013prh <- subset (march2013h, WBAN == 11641); april2013prh <- subset (april2013h, WBAN == 11641)
may2013prh <- subset (may2013h, WBAN == 11641); june2013prh <- subset (june2013h, WBAN == 11641)
july2013prh <- subset (july2013h, WBAN == 11641); aug2013prh <- subset (aug2013h, WBAN == 11641)
sept2013prh <- subset (sept2013h, WBAN == 11641); oct2013prh <- subset (oct2013h, WBAN == 11641)
nov2013prh <- subset (nov2013h, WBAN == 11641); dec2013prh <- subset (dec2013h, WBAN == 11641)

# rowbind hourly datasets by year, then all three years
pr2011h <- rbind (jan2011prh, feb2011prh, march2011prh, april2011prh, may2011prh, june2011prh, july2011prh, aug2011prh, sept2011prh, oct2011prh, nov2011prh, dec2011prh)

pr2012h <- rbind (jan2012prh, feb2012prh, march2012prh, april2012prh, may2012prh, june2012prh, july2012prh, aug2012prh, sept2012prh, oct2012prh, nov2012prh, dec2012prh)

pr2013h <- rbind (jan2013prh, feb2013prh, march2013prh, april2013prh, may2013prh, june2013prh, july2013prh, aug2013prh, sept2013prh, oct2013prh, nov2013prh, dec2013prh)

prclimatedatah <- rbind (pr2011h, pr2012h, pr2013h)

# change variables classess
prclimatedatah$RelativeHumidity <- as.numeric(prclimatedatah$RelativeHumidity)

prclimatedatah$Date <- ymd(as.character(prclimatedatah$Date))

prclimatedatah$WBAN <- as.factor(prclimatedatah$WBAN)

# obtain average relative humidity per day 
RH <- dcast(prclimatedatah, Date~WBAN, mean)

RelativeHumidity <- RH[2]

names (RelativeHumidity) <- c("RH")

# column bind with Relvative Humidity with prclimateshort dataset

prclimatefinal <- cbind(prclimateshort, RelativeHumidity)

# writing the final dataset as csv and Excel files
## remove the 1st column

prclimatefinal1 <- prclimatefinal[,-c(1)]
write.table (prclimatefinal1, file = "prclimatefinal.csv", sep = ",", col.names = NA, qmethod = "double")

library (xlsx)
write.xlsx(prclimatefinal,"prclimatefinal.xlsx", sheetName="DatosPR")

# Convert temperatures from Farenheit to Celsius
prclimatexlsx <- mutate (prclimatexlsx, TmaxC = (Tmax - 32)*(5/9))
prclimatexlsx <- mutate (prclimatexlsx, TminC = (Tmin - 32)*(5/9))
prclimatexlsx <- mutate (prclimatexlsx, TavgC = (Tavg - 32)*(5/9))

# Convert precipitation from inches to mm
prclimatexlsx <- mutate (prclimatexlsx, Precipmm = PrecipTotal * 25.4)

# Descriptive statistics of columns to extract TmaxC, TminC, and Tavg, and RH
summary (prclimatexlsx, na.rm = TRUE)

# Sum of precipitation column
sum(prclimatexlsx$Precipmm, na.rm = TRUE)
