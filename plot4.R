library(dplyr)
library(ggplot2)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")

##Pull coal combustion data
combcoal<-grepl("Fuel Comb.*Coal", classcodes$EI.Sector)
CCcombcoal<-classcodes[combcoal, ]$SCC
NEIcombcoal<-NEIdata[NEIdata$SCC %in% CCcombcoal,]
NEIcoalsums<-NEIcombcoal %>%
  group_by(year) %>%
  summarize(yeartotal = sum(Emissions))
  
##Create plot4.png
png("plot4.png", width = 960, height = 480)
ggplot(NEIcoalsums, aes(x=factor(year), y=yeartotal/100000, fill=year))+
  geom_bar(stat = "identity") +
  labs(x="year", y=expression("PM2.5 Emissions in 100,000 Tons"), 
       title = expression("PM2.5 Coal Emisions in US 1999-2008"))
dev.off()