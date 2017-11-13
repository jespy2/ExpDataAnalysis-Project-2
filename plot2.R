library(dplyr)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")

##Pull Baltimore data, then create annual sums variable
baltimoredata<-NEIdata %>% 
  filter(fips=="24510") %>%
  group_by(year) %>%
  filter(year==1999|2002|2005|2008) %>%
  summarize(yeartotal = sum(Emissions))



##Create plot2.png
png("plot2.png", width = 480, height = 480)
plot(baltimoredata$year, baltimoredata$yeartotal, 
     type="l",xlab= expression("Year"), ylab = expression("Tons of PM2.5 Emisions"),
     main="PM2.5 Emissions in Baltimore 1999-2008")
dev.off()


