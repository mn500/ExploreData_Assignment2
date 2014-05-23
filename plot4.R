## plot4.R
## R packages used during data processing.
library(dplyr)
## Zip files were downloaded and saved to EmissionsData folder.
## Working directory was set to EmissionsData folder. 
setwd("./EmissionsData")
## Read in the summary data and source classification code. 
a<-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Parse data into total coal emissions per year for the United States.
## Obtain 99 codes for coal burning from the EI.Sector. 
s <- select(SCC, SCC, EI.Sector)
length(which(grepl("Coal", ignore.case=T, s$EI.Sector)))
s1 <- s[grepl("Coal", ignore.case=T, s$EI.Sector),]
s2 <- select(s1, SCC)
## Parsing is similar to that done for other plots except all 99 codes for coal are evaluated.
plot4 <- a %.% select(SCC, Emissions, year) %.%
  filter(SCC %in% s2$SCC) %.%
  group_by(year) %.%
  summarise(sumEmissions=sum(Emissions))
plot4
## Plotted the total emissions per year for Baltimore Maryland.
## Answer 4: yes, total emissions of PM2.5 from coal combustion-related sources 
## has decrease from 1999-2008, but most notably from 2004 to 2008.
png(filename="plot4.png",width=700,height=460, type = c("windows"))
plot(plot4$sumEmissions~plot4$year, type = "b", lwd = 2, pch = 19, 
     col = "darkblue", xlab = "Year", 
     ylab = "Total Emissions from Coal per Year (tons)", 
     cex.lab = 1.2, cex.main = 1.5, col.main = "darkblue",
     main = expression(paste("Amount of Fine Particulate Matter (PM"[2.5],") from Coal in United States from 1999-2008")))
dev.off()