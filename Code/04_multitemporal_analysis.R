#R CODE FOR PERFORMING MULTITEMPORAL ANALYSIS
#multitemporal distribution of NO3 over time


#Packages 
install.packages("ggridges")     #this is needed to create ridgeline plots 
library(ggridges)
library(imageRy)
library(terra)
library(viridis)


#Content of the package 
im.list()


#JANUARY 2020 ----------------------------------------------------------------------------------------------------------------------------------------------------
EN_01=im.import("EN_01.png")
EN_01=flip(EN_01)
plot(EN_01)
#RGB image with rainbow colors (wrong colors)
#higher values -> areas where the vehicular traffic is higher 


#MARCH 2020 -------------------------------------------------------------------------------------------------------------------------------------------------------
EN_13=im.import("EN_13.png")
EN_13=flip(EN_13)
plot(EN_13)
#the spots have decreased


#EXERCISE: plot the two images one beside the other
#🖼️ Multiframe
im.multiframe(1,2)
plot(EN_01)
plot(EN_13)


#Difference between the two images --------------------------------------------------------------------------------------------------------------------------------
ENdif = EN_01[[1]] - EN_13[[1]]     #January - March 
plot(ENdif)
#difference (yellow) -> move towards January -> areas where values ​ decreased 
#inverse difference (blue) -> move towards March -> areas where values ​​remained high or even increased


#Plot with inferno colors (from viridis package)
plot(ENdif, col=inferno(100))


#🧊 GREENLAND DATASET ICE MELT -----------------------------------------------------------------------------------------------------------------------------------
#depending on the temperature
#the lowest temperatures are concentrated in the center
gr=im.import("greenland")


#🖼️ Multiframe
im.multiframe(1,2) 
plot(gr[[1]], col=rocket(100))     #Greenland 2000
plot(gr[[4]], col=rocket(100))     #Greenland 2015
#in this case, fluctuations are also identified, not just actual climate change


#Difference between the two images
grdif = gr[[1]] - gr[[4]]     #Greenland 2000 - Greenland 2015
dev.off()
plot(grdif)      #plot of the difference 
#blue zones -> highest values of temperature in 2015


#📉 Ridgeline plots -----------------------------------------------------------------------------------------------------------------------------------------------
#useful for analyzing the distribution (ex. frequency)
im.ridgeline(gr, scale=1)     #[im.ridgeline=create a ridgeline plot]
                              #[scale=set the vertical scale of the graph]
                              #[palette=set the colors]
#in this case it is difficult to find a trend because they are fluctuations
#takes all the pixels and calculates the pixel frequencies

im.ridgeline(gr, scale=2)
#instead of remaining in its own part of the graph it overlaps the next one
im.ridgeline(gr, scale=2, palette="inferno")
im.ridgeline(gr, scale=3, palette="inferno")

#⛰️ BRENTA MOUNTAIN RANGE ------------------------------------------------------------------------------------------------------------------------------------------
#EXERCISE: import the NDVI data
ndvi=im.import("Sentinel2_NDVI")


# Changing names 
# Sources:    Sentinel2_NDVI_2020-02-21.tif  
#             Sentinel2_NDVI_2020-05-21.tif  
#             Sentinel2_NDVI_2020-08-01.tif  
#             Sentinel2_NDVI_2020-11-27.tif  


# Change of the names
names(ndvi) = c("02_Feb", "05_May", "08_Aug", "11_Nov") 


#📉Ridgeline plot -----------------------------------------------------------------------------------------------------------------------------------------------
im.ridgeline(ndvi, scale=2)

#graphics problem -> devoff()

plot(ndvi)
im.ridgeline(ndvi, scale=2)
im.ridgeline(ndvi, scale=2, palette="mako")
#lower values -> lower biomass values ​​for the time of year
#biomass values increase until August-September
#biomass values return as before in November


#📈 Scatterplots -------------------------------------------------------------------------------------------------------------------------------------------------
pairs(ndvi)
plot(ndvi[[1]], ndvi[[2]])

# y = x 
# May y-axis
# February x-axis
# y = a + bx (equation of a straight line)
# a = 0, b = 1 (coefficients for equality x=y)
# y = a + bx = 0 + 1x = x

#1 to 1 line
abline(0, 1, col="red")     #[abline=defines a straight line, specifying the coefficients] 


#Setting datasets with the same range
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")     #straight line
#when the line is above, it means that the data is higher in May than in February


#🖼️ Multiframe
im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")
