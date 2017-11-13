library(dplyr)


##Read in data
NEIdata<-readRDS("./summarySCC_PM25.rds")
classcodes<-readRDS("./Source_Classification_Code.rds")

##Pull tons of pollution by year, then create annual sums variable
yeardata<-NEIdata %>% group_by(year) %>%
  filter(year==1999|2002|2005|2008) %>%
  summarize(yeartotal = sum(Emissions))


##Create plot1.png
png("plot1.png", width = 480, height = 480)
plot(yeardata$year, yeardata$yeartotal/1000000, 
     type="l",xlab= expression("Year"), ylab = expression("Tons in Millions of PM2.5 Emissions"))
dev.off()


