library(dplyr)
library(ggplot2)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")


##Pull vehicles data 
vehicles<-grepl("Vehicles", classcodes$EI.Sector)   ##pull vehicle tags
CCVehicles<-classcodes[vehicles, ]$SCC              ##pull SCC #'s for vehicles
NEIVehicles<-NEIdata[NEIdata$SCC %in% CCVehicles,]  ##pull vehicles from NEI data

##Pull Baltimore data
baltimoredata<-NEIVehicles %>% 
  filter(fips=="24510") %>%
  group_by(type, year) %>%
  summarize(yeartotal = sum(Emissions))             ##organize by year and create annual sum variable
baltimoredata$location<-"Baltimore"

##Pull Los Angeles County data
ladata<-NEIVehicles %>% 
  filter(fips=="06037") %>%
  group_by(type, year) %>%
  summarize(yeartotal = sum(Emissions))             ##organize by year and create annual sum variable
ladata$location<-"Los Angeles County"

##Combine datasets
allvehicle<-rbind(baltimoredata,ladata)

##Create plot6.png
png("plot6.png", width = 960, height = 480)
ggplot(allvehicle, aes(x=factor(year), y=yeartotal, fill=location))+
  geom_bar(aes(fill=year), stat = "identity") +
  facet_grid(scales="free", space="free", .~location) +
  guides(fill=FALSE) +
  labs(x="year", y=expression("PM2.5 Emissions in Tons"), title = expression("PM2.5 Vehicle Emisions in Baltimore & LA County 1999-2008"))
dev.off()