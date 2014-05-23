## plot3.R
## R packages used during data processing.
library(dplyr)
library(ggplot2)
## Zip files were downloaded and saved to EmissionsData folder.
## Working directory was set to EmissionsData folder. 
setwd("./EmissionsData")
## Read in the summary data. 
a<-readRDS("summarySCC_PM25.rds")
## Transform data and then parse data into total emissions 
## per emissions source type per year for Baltimore Maryland.
a1 <- transform(a, fips = as.character(fips),
                Emissions = as.numeric(Emissions), 
                year = as.integer(year),
                type = as.factor(type))
plot3 <- a1 %.% select(fips, Emissions, type, year) %.%
  filter(fips == 24510) %.%
  group_by(year, type) %.%
  summarise(sumEmissions=sum(Emissions))
plot3
## Plotted the total emissions per year for Baltimore Maryland as a function of emission source type.
## Answer 3: in Baltimore Maryland from 1999-2008 all emission source types decreased except
## for the point of emission sourse that increased in 2002-2004, but then lowered in 2008 to level
## that was only slightly higher than in 1999.
png(filename="plot3.png",width=800,height=600, type = c("windows"))
ggplot(plot3, aes(x=year, y=sumEmissions, colour=type)) + 
  geom_smooth(method="loess", aes(group=type), lwd=1.2) +
  geom_point(size=4) +
  scale_color_manual(values = c("red", "black", "darkblue", "blue")) +
  ggtitle(expression(paste("Amount of Fine Particulate Matter"~(PM[2.5])~ "by Type in Baltimore, Maryland from 1999-2008"))) +
  xlab("Year") +
  ylab("Total Emissions per Year (tons)") +
  theme(text = element_text(size=18)) +
  theme(plot.title = element_text(size = 18,colour="blue"))
dev.off()