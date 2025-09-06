 #First R coding from scatch 

2+3

anna <- 2 + 3     #assign an operation to an object 
chiara <- 4 + 6 

anna + chiara 

filippo <- c(0.2, 0.4, 0.6, 0.8, 0.9)     #creating an array
luca <- c(100, 80, 60, 50, 10) 

plot (luca, filippo, pch=19)    #define a plot [pch=plotting character]
plot (luca, filippo, pch=19, col="blue")     #[coL=color]
plot (luca, filippo, pch=19, col="blue", cex=2)     #[cex=character esxpansions]
plot (luca, filippo, pch=19, col="blue", cex=2, xlab="rubbish", ylab="biomass")     #[xlab=x-axis label name, ylab=y-axis label name]

#installing packages 
#CRAN

install.packages("terra")     #installation of the package 
library(terra)     #package loading 

install.packages("devtools")
library(devtools) 

install_github("ducciorocchini/imageRy")
library(imageRy)
