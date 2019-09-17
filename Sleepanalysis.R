# This script is for an analysis of my sleep schedule
# It includes relationships between sleep time, wake time, and duration

getwd()
setwd("C:/Users/Jaret/Documents/")
# Yes, I know how messy it is to just dump everything into /Documents/, no I will not be changing this (for the time being)
getwd()

slpdat = read.table("sleeptrack090619.prn",header = TRUE)
# Change filename as needed, this is the first file I had

slpdat$decST = slpdat$decST + ifelse(slpdat$decST <= 6, 24, 0)
# This allows us to treat a night as a continuous event, rather than breaking the histogram at midnight

slpdat$Cycles = slpdat$Hours / 1.5 
# This calculates the number of sleep cycles for each sleep. This is an estimate based on a 90 minute sleep cycle, which is really only true for the first cycle of the night (after which they get longer between 110-120 minutes)

sleeptime_hist = hist(slpdat$decST,freq = TRUE,
                      main="Figure 1: Histogram of Sleep Times",
                      xlab="Sleep Time",
                      breaks=seq(20,30,.25))

waketime_hist = hist(slpdat$decWT,freq = TRUE,
                     main="Figure 2: Histogram of Wake Times",
                     xlab="Wake Time",
                     breaks=seq(0,24,.25))

hours_hist = hist(slpdat$Hours,freq = TRUE, 
                  main="Figure 3: Histogram of Sleep Duration",
                  xlab="Sleep Duration",
                  breaks=seq(0,12,.25))

cycles_hist = hist(slpdat$Cycles,freq = TRUE,
                   main="Figure 4: Histogram of Sleep Cycles",
                   xlab="Sleep Cycles",
                   breaks=seq(0,8,1))

# Visualize the data

plot(slpdat$decWT,slpdat$decST,
     main="Figure 5: Sleep Time versus Wake Time",
     xlab="Wake Time",ylab="Sleep Time",xlim=c(5,24),
     ylim=c(20,30),col="blue",lty=1,lwd=1,pch=1)

plot(slpdat$decWT,slpdat$Hours,
     main="Figure 6: Hours versus Wake Time",
     xlab="Wake Time",ylab="Hours",xlim=c(0,24),
     ylim=c(0,12),col="blue",lty=1,lwd=1,pch=1)

plot(slpdat$decST,slpdat$Hours,
     main="Figure 7: Hours versus Sleep Time",
     xlab="Sleep Time",ylab="Hours",xlim=c(20,30),
     ylim=c(0,12),col="blue",lty=1,lwd=1,pch=1)

# Visualize the relationships between the data
# slpdat$Cycles is omitted because it is simply a function of slpdat$Hours

print(cor(slpdat$decST,slpdat$decWT))
print(cor(slpdat$decST,slpdat$Hours))
print(cor(slpdat$decWT,slpdat$Hours))

# Determine strength and direction of relationships
