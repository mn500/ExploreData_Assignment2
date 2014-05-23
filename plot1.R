## plot1.R
## R packages used during data processing.
library(dplyr)
## Zip files were downloaded and saved to EmissionsData folder.
## Working directory was set to EmissionsData folder. 
setwd("./EmissionsData")
## Read in the summary data. 
a<-readRDS("summarySCC_PM25.rds")
## Parse data into total emissions per year in the United States.
plot1 <- a %.% select(Emissions, year) %.%
  group_by(year) %.%
  summarise(sumEmissions = sum(Emissions))
## Plotted the total emissions per year.
## Answer 1: yes, total emissions from PM2.5 has decreased in the United States from 1999-2008.  
png(filename="plot1.png",width=700,height=460, type = c("windows"))
plot(plot1$sumEmissions~plot1$year, type = "b", lwd = 2, col = "brown", cex.main = 1.5,
     col.main = "darkblue", xlab = "Year", 
     ylab = "Total Emissions per Year (tons)", cex.lab = 1.2,
     main = expression(paste("Amount of Fine Particulate Matter (PM"[2.5],") in the United States from 1999-2008"))) 
dev.off()
