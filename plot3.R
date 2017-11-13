library(dplyr)
library(ggplot2)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")

##Pull Baltimore data, then create annual sums variable
baltimoredata<-NEIdata %>% 
  filter(fips=="24510") %>%
  group_by(type, year) %>%
  summarize(yeartotal = sum(Emissions))

##Create plot3.png
png("plot3.png", width = 960, height = 480)
ggplot(baltimoredata, aes(x=factor(year), y=yeartotal, fill=type))+
  geom_bar(stat = "identity") +
  facet_grid(.~type) +
  labs(x="year", y=expression("Tons of PM2.5 Emissions"), 
       title = expression("PM2.5 Emisions in Baltimore by Source Type 1999-2008"))
dev.off()