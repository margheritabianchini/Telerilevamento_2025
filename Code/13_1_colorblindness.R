#R CODE TO SOLVE COLORBLINDNESS PROBLEMS 


#Packages
library(terra)
library(imageRy)


#Installing cblindplot
library(devtools)
install_github("ducciorocchini/cblindplot")
library(cblindplot)



#Importing data
setwd("~/Desktop")     #select the working directory      


#https://fb.watch/xfBsEdtO4Z/
vinicunca = rast("vinicunca.jpg")     #[rast=define a raster]
plot(vinicunca)
vinicunca = flip(vinicunca)
plot(vinicunca)


#Simulating colorblindness
#🖼️ Multiframe 
im.multiframe(2,1)
im.plotRGB(vinicunca, r=1, g=2, b=3, title="Standard Vision")
im.plotRGB(vinicunca, r=2, g=1, b=3, title="Protanopia")


#Solving colorblindness
dev.off()
rainbow = rast("rainbow.jpg")
plot(rainbow)
rainbow = flip(rainbow)
plot(rainbow)


cblind.plot(rainbow, cvd="protanopia")
cblind.plot(rainbow, cvd="deuteranopia")
cblind.plot(rainbow, cvd="tritanopia")
