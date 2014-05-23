## plot5.R
## R packages used during data processing.
library(dplyr)
## Zip files were downloaded and saved to EmissionsData folder.
## Working directory was set to EmissionsData folder. 
setwd("./EmissionsData")
## Read in the summary data and source classification code. 
a<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Parse data into total vehicle emissions per year for Baltimore Maryland.
## Obtain 1138 codes for vehicle emissions from the EI.Sector. 
length(which(grepl("Vehicles", ignore.case=T, s$EI.Sector)))
v <- s[grepl("Vehicles", ignore.case=T, s$EI.Sector),]
v2 <- select(v, SCC)
bv <- a %.% select(fips, SCC, Emissions, year) %.%
  filter(fips == 24510, SCC %in% v2$SCC) %.%
  group_by(year) %.%
  summarise(sumEmissions=sum(Emissions))
bv
## Plotted the total vehicular emissions per year for Baltimore Maryland from 1999-2008.
## Answer 5: yes, total PM2.5 from vehicular emissions 
## has decreased in Baltimore Maryland from 1999-2008.
png(filename="plot5.png",width=800,height=460, type = c("windows"))
plot(bv$sumEmissions~bv$year, type = "b", lwd = 2, pch = 19, col = "darkblue",
     xlab = "Year", ylab = "Total Emissions from Motor Vehicles per Year (tons)",
     cex.lab = 1.2, cex.main = 1.4, col.main = "darkblue",
     main = expression(paste("Amount of Fine Particulate Matter (PM"[2.5],") from Motor Vehicles in Baltimore, Maryland from 1999-2008")))
dev.off()