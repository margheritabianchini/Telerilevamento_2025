# R code for visualizing satellite data




library(terra)
library(imageRy)


im.list()

#For the whole course we are going to use of= instead of <-
#This is based on the following video: 

b2=im.import("sentinel.dolomites.b2.tif")


cl=colorRampPalette(c("black", "dark grey", "light grey"))(100)
#questi colori sono tre elementi di un array 
#all'esterno il numero di gamme tra parentesi 
plot(b2, col=cl)

cl=colorRampPalette(c("black", "dark grey", "light grey"))(3)
plot(b2, col=cl)

#Exercise: make your own color ramp
cl=colorRampPalette(c("purple2", "paleturquoise", "violetred1"))(100)
plot(b2, col=cl)


