#R CODE FOR VISUALIZING SATELLITE DATA 
#for the whole course we are going to use of = instead of <- for assigning values ​​to variables

#Packages
#always at the beginning of the code 
library(terra)
library(imageRy)
library(viridis)


#Content of the package 
im.list()     #[im.list=lists the files contained in the package]


#SENTINEL-2 BANDS (spatial resolution = 10m)
#DOLOMITES 
b2=im.import("sentinel.dolomites.b2.tif")     #[im.import=import of the blue band]
                                              #the image represent the mountain group of Tofane (Dolomites) in the blue wave lenght 
                                              #the yellow part of the image means that it reflects a lot of blue


#🎨 Color array ------------------------------------------------------------------------------------------------------------------------------------------------
cl=colorRampPalette(c("black", "dark grey", "light grey"))(100)     #[colorRampPalette=create a palette with the indicated colors]
                                                                    #[c=concatenate function that combine three color (elements of an array)]
                                                                    #[(100)=number of colors]
plot(b2, col=cl)

cl=colorRampPalette(c("black", "dark grey", "light grey"))(3)
plot(b2, col=cl)


#EXERCISE: make your own color ramp
cl=colorRampPalette(c("purple2", "paleturquoise", "violetred1"))(100)
plot(b2, col=cl)


#Band 2(blue)
b2=im.import("sentinel.dolomites.b2.tif")
#band 3(green) 
b3=im.import("sentinel.dolomites.b3.tif")
#band 4(red)
b4=im.import("sentinel.dolomites.b4.tif")
#band8 (NIR - near infrared)
b8=im.import("sentinel.dolomites.b8.tif")


#⛓️ Bands on an array ---------------------------------------------------------------------------------------------------------------------------------------------
par(mfrow=c(1,4))     #[par=set the graphical parameters]
                      #[mfrow=create an array of images]
                      #array of 1 row and 4 columns
b2=im.import("sentinel.dolomites.b2.tif")    #list of images to represent
b3=im.import("sentinel.dolomites.b3.tif")
b4=im.import("sentinel.dolomites.b4.tif")
b8=im.import("sentinel.dolomites.b8.tif")

#or in another way
par(mfrow=c(1,4))
plot(b2)     #list of plot to represent
plot(b3)
plot(b4)
plot(b8)

dev.off()     #[dev.off=closing the device]


#🖼️ Multiframe --------------------------------------------------------------------------------------------------------------------------------------------------
im.multiframe(1,4)     #[im.multiframe=create a plot with different plot inside]
plot(b2)               #plot to represent 
plot(b3)
plot(b4)
plot(b8)


#EXERCISE: plot the bands using im.multiframe() one on top of the other 
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)


#Box
im.multiframe(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)


#Color ramp palette 
cl=colorRampPalette(c("black", "light grey"))(100)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)


#Stack
sent=c(b2,b3, b4, b8)
plot(sent, col=cl)


#Change of the names
names(sent)=c("b2blue", "b3green", "b4red", "b8NIR")     #[names=assign names to the elements of a vector]
sent     #file information (dimensions, resolution, coordinate reference system, ...)
plot(sent, col=cl)
plot(sent) 
dev.off()


#Plot of a single image from an array of images 
plot(sent$b8NIR)     #plotting only the b8NIR inside the sent array 
plot(sent[[4]])      #plotting the fourth element of the array


#Several bands altogether 
sentdol=im.import("sentinel.dolomites")     #replaces everything done before


#📈 Scatterplots -------------------------------------------------------------------------------------------------------------------------------------------------
pairs(sentdol)     #[pairs=produce a matrix of scatterplots]
                   #diagonal=histograms of the distribution of values ​​for each band
                   #upper right=Pearson correlation coefficients
                   #lower left=scatterplots
                   #the results show that with the NIR the correlation decreases (larger area)
                   #plants reflects a lot in the NIR band (high values)
                   #if instead it is absorbed in a band of a color (low values)


#Color ramp 
plot(sentdol, col=viridis(100))     #viridis setting
plot(sentdol, col=mako(100))     #mako setting  


#Layers (bands)
#1= blue (b2)
#2= green (b3)
#3= red (b4)
#4= NIR (b8)


#🌈 Natural colors -----------------------------------------------------------------------------------------------------------------------------------------------
im.plotRGB(sentdol, r=3, g=2, b=1)     #[im.plotRGB=combines three bands into one RGB image]
                                       #visible visualization: in the visible we can use three bands at a time


#👻 False colors -------------------------------------------------------------------------------------------------------------------------------------------------
im.plotRGB(sentdol, r=4, g=3, b=2)     #adding one on the components of the RGB scheme
                                       #exclusion of the blue band                           
                                       #the NIR band is present in the red component
                                       #plants reflect a lot the NIR
                                       #the NIR is reflected as much by healthy plants


#EXERCISE: plot the image using the NIR ontop of the green component of the RGB scheme 
im.plotRGB(sentdol, r=2, g=4, b=3)
pairs(sentdol)                         #the correlation between blue, green, and red is strong
                                       #while with NIR the variation is evident

im.plotRGB(sentdol, r=3, g=4, b=2)     #same result

#Comparison of the two plotRGB 
im.multiframe(1, 2)
im.plotRGB(sentdol, r=2, g=4, b=3)
im.plotRGB(sentdol, r=3, g=4, b=2)

im.plotRGB(sentdol, r=3, g=2, b=4)     #the higher the reflectance of a band, the more dominant it will be in the resulting RGB scheme
                                       #as in this case the NIR band
