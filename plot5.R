library(dplyr)
library(ggplot2)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")


##Pull vehicles data for Baltimore
vehicles<-grepl("Vehicles", classcodes$EI.Sector)   ##pull vehicle tags
CCVehicles<-classcodes[vehicles, ]$SCC              ##pull SCC #'s for vehicles
NEIVehicles<-NEIdata[NEIdata$SCC %in% CCVehicles,]  ##pull vehicles from NEI data
baltimoredata<-NEIVehicles %>% 
  filter(fips=="24510") %>%
  group_by(type, year) %>%
  summarize(yeartotal = sum(Emissions))             ##organize by year and create annual sum variable

  
##Create plot5.png
png("plot5.png", width = 960, height = 480)
ggplot(baltimoredata, aes(x=factor(year), y=yeartotal, fill=year))+
  geom_bar(stat = "identity") +
  guides(fill=FALSE)
  labs(x="year", y=expression("PM2.5 Emissions in Tons"), 
       title = expression("PM2.5 Vehicle Emisions in Baltimore 1999-2008"))
dev.off()
