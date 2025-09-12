#R CODE FOR CALCULATING SPATIAL VARIABILITY
#how much the system varies


#Packages 
library(terra)
library(imageRy)
library(viridis)
library(patchwork)
install.packages("RStoolbox")
library(RStoolbox)


# -----------------------------------------------------------------------------------------------------------------------------------------------------------------
# -> MEAN = sum of the sample values ​​divided by their number
# -> MEDIAN = indicates the central value of the sorted samples
# -> VARIANCE = sum of the quadratic deviations divided by the number of samples taken 
# -> STANDARD DEVIATION of the population = square root of variance
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------


#EXAMPLE
#24 26 25 

#Avarage
media = (24+25+26) / 3
#25

#Variance and standard deviation 
num = (24-media)^2 + (26-media)^2 + (25-media)^2     #sum of the quadratic deviations
den = 3     #number of samples taken
variance = num/den    #variance
#0.6666667
stdev = sqrt(variance)     #standard deviation 
#0.8164966


#Standard deviation variation (automatic)
#Three samples 
sd(c(24,26,25))    #[sd=automatic standard deviation on the sample (n-1)]
                   #with many samples it wouldn't change much
#1

#Four samples
sd(c(24,26,25,49))     #extending the curve towards one side
#12.02775


#Mean variation (automatic) 
#Three samples 
mean(c(24,26,25))
#25

#Four samples 
mean(c(24,26,25,49))
#31


#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Content of the package 
im.list()


#🛰️SENTINEL-2 (spatial resolution = 10m)
sent = im.import("sentinel.png")
sent=flip(sent)


#Layer (band)
#1=NIR 


#EXERCISE: plot the image in RGB with the NIR ontop of the red component
im.plotRGB(sent, r=1, g=2, b=3)


#EXERCISE: make three plot with NIR ontop of each component:r, g, b
#it doesn't change where you put 2 or 3
#it only depends on the NIR
#🖼️ Multiframe 
dev.off()
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)
#fluorescent green are the high altitude prairies
#white is snow or clouds 


#------------------------------------------------------------------------------------------------------------------------------------------------------------------
nir = sent[[1]]


#EXERCISE: plot the NIR band with the inferno 
plot(nir, col=inferno(100))


#Standard deviation on a 3x3 matrix 
sd3 = focal(nir, w=c(3,3), fun=sd)     #[focal=work pixel by pixel]
                                       #[w=window size]
                                       #[fun=function to apply]
plot(sd3)
#areas where there has been a change in the NIR
#variation in crevasses, vegetation


#🖼️ Multiframe 
im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)


#Standard deviation on a 5X5 matrix 
#For detail variations I will use a smaller moving window
dev.off()
sd5 = focal(nir, w=c(5,5), fun=sd)
plot(sd5)


#🖼️ Multiframe 
im.multiframe(1,2)
plot(sd3)
plot(sd5)


#EXERCISE: use ggplot to plot the standard deviation
#function to plot individual bands
im.ggplot(sd3)


#🖼️ Multiframe: difference between plot and ggplot
dev.off()
plot(sd3)
im.ggplot(sd3)


#EXERCISE: plot the two sd maps (3 or 5) one beside the other with ggplot 
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd5)
p1 + p2     #the graphs are side by side


#Plot of the original NIR and the standard deviations 
p3=im.ggplot(nir)
p3 + p1     #the graphs are side by side


#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#What to do in case of huge images 
#RESAMPLE - reduction of spatial resolution


#Content of the package 
im.list()


#🛰️SENTINEL-2 BANDS (spatial resolution = 10m)
sent = im.import("sentinel.png")
sent = flip(sent)
plot(sent)


#Total number of pixels 
ncell(sent) * nlyr(sent)     #[ncell=total number of pixels]
                             #[nlyr=number of layers (bands)]
#633612 * 4
#2534448


#Resample ---------------------------------------------------------------------------------------------------------------------------------------------------------
#Resampling means reducing by the square
senta = aggregate(sent, fact=2)     #[aggregate=reduce the spatial resolution]
                                    #[fact= scale factor]
                                    #the resolution is 2 * 2 because I multiply by 2 each side of the square that represents the pixel
                                    #the initial pixel is 1/4 of the output pixel
                                    #larger area -> lower resolution 
ncell(senta) * nlyr(senta)
#633612
#dividing them we get 4, because we reduced it 4 times [fact=2]


senta5 = aggregate(sent, fact=5)
ncell(senta5) * nlyr(senta5)
#101760


#Standard deviation -----------------------------------------------------------------------------------------------------------------------------------------------
nira = senta [[1]]
sd3a = focal(nira, w=c(3,3), fun=sd)     #standard deviation on a 3x3 matrix 

#EXERCISE: make a multiframe and plot in RGB the three images (or 2, 5)
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(senta, r=1, g=2, b=3)
im.plotRGB(senta5, r=1, g=2, b=3)
#the effect of resampling is evident
#with a factor of 5 the image detail is lost
#but the highest resolution is not always better than the lowest one
#ex. a high resolution image may create more noise


nira = senta [[1]]
sd3a = focal(nira, w=c(3,3), fun=sd)
plot(sd3a)


#EXERCISE: calculate the standard deviation for the factor 5 image 
nira5 = senta5 [[1]]
sd3a5 = focal(nira5, w=c(3,3), fun=sd)     #standard deviation on a 3x3 matrix 
plot(sd3a5)


sd5a5 = focal(nira5, w=c(5,5), fun=sd)
plot(sd5a5)


#🖼️ Multiframe 
im.multiframe(1,2)
plot(sd5a5)
plot(sd3a)


#🖼️ Multiframe 
im.multiframe(2,2)
plot(sd3)
plot(sd3a)      #resampling factor 2
plot(sd3a5)     #resampling factor 5 
plot(sd5a5)     #resampling factor 5 and 5*5 mobile window


#Plot of the standard deviation 
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd3a)
p3 = im.ggplot(sd3a5)
p4 = im.ggplot(sd5a5)

p1 + p2 + p3 + p4 


#🖼️ Multiframe with a color ramp setting 
im.multiframe(2,2)
plot(sd3, col=mako(100))
plot(sd3a, col=mako(100)) 
plot(sd3a5, col=mako(100)) 
plot(sd5a5, col=mako(100)) 


#Variance ---------------------------------------------------------------------------------------------------------------------------------------------------------
var3 = focal(nir, w=c(3,3), fun=var)    #variance
#or var3 = sd3^2 


sd5 = focal(nir, w=c(5,5), fun="sd")    #standard deviation 
var5=sd5^2                              #variance 
plot(sd5)     #plot of the standard deviation 
plot(var5)    #plot of the variance 
