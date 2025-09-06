#FIRST R CODING FROM SCATCH 

#operation 
2+3


#object 
anna <- 2 + 3     #assign an operation to an object 
chiara <- 4 + 6 
anna + chiara 


#array 
filippo <- c(0.2, 0.4, 0.6, 0.8, 0.9)     #creating an array
luca <- c(100, 80, 60, 50, 10) 


#plot
plot (luca, filippo, pch=19)    #define a plot [pch=plotting character]
plot (luca, filippo, pch=19, col="blue")     #[coL=color]
plot (luca, filippo, pch=19, col="blue", cex=2)     #[cex=character esxpansions]
plot (luca, filippo, pch=19, col="blue", cex=2, xlab="rubbish", ylab="biomass")     #[xlab=x-axis label name, ylab=y-axis label name]


#installing packages 
#CRAN: it is a network of servers, which represents a repository of R resources
install.packages("terra")     #installation of the package 
library(terra)     #package loading 

install.packages("devtools")
library(devtools) 

install_github("ducciorocchini/imageRy")
library(imageRy)
