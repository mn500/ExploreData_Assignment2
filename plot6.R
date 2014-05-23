## plot6.R
## R packages used during data processing.
library(dplyr)
library(ggplot2)
## Zip files were downloaded and saved to EmissionsData folder.
## Working directory was set to EmissionsData folder. 
setwd("./EmissionsData")
## Read in the summary data and source classification code. 
a<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Parse data into total vehicle emissions per year for Baltimore Maryland
## and Los Angeles County, California from 1999-2008.
## Obtain 1138 codes for vehicle emissions from the EI.Sector. 
v <- s[grepl("Vehicles", ignore.case=T, s$EI.Sector),]
v2 <- select(v, SCC)
## Data for Los Angeles County, California (LA). 
lav <- a %.% select(fips, SCC, Emissions, year) %.%
  filter(fips == "06037", SCC %in% v2$SCC) %.%
  group_by(year) %.%
  summarise(sumEmissions=sum(Emissions))
## Data for Baltimore Maryland (Balt).
bv <- a %.% select(fips, SCC, Emissions, year) %.%
  filter(fips == 24510, SCC %in% v2$SCC) %.%
  group_by(year) %.%
  summarise(sumEmissions=sum(Emissions))
## Data sets are combined and data for LA and Balt are identified.
comb <- rbind(lav,bv)
loc<-c('LA','LA','LA','LA','Balt','Balt','Balt','Balt')
comb1 <- cbind(loc,comb)
comb1
lav
bv
## Plotted the total vehicular emissions per year for Baltimore Maryland from 1999-2008
## and Los Angeles County, California from 1999-2008.
## Answer 6: While Baltimore Maryland has seen a decrease (from 347 tons in 1999 to 88 tons in 2008) in total PM2.5 from vehicular emissions,
## Los Angeles County, California has seen an increase (from 3931 tons in 1999 to tons 4101 in 2008) during the 1999-2008 period.
png(filename="plot6.png",width=648,height=432, type = c("windows"))
ggplot(comb1, aes(x=year, y=sumEmissions, colour=loc, shape=loc)) + 
  geom_smooth(method="loess", aes(group=loc), lwd=1.2) +
  geom_point(size=4) +
  scale_color_manual(values = c("red", "darkblue")) +
  ggtitle(expression(atop(paste("Amount of Fine Particulate Matter"~(PM[2.5])~ "from Motor Vehicles"), atop("in Baltimore, Maryland (Balt) and Los Angeles County, California (LA) from 1999-2008", "")))) +
  xlab("Year") +
  ylab("Total Emissions per Year (tons)") +
  theme(text = element_text(size=18)) +
  theme(plot.title = element_text(size = 20,colour="blue")) 
dev.off() 