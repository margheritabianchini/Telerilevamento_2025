#R CODE FOR VISUALIZING SATELLITE DATA 
#for the whole course we are going to use of = instead of <- for assigning values ​​to variables

#Installing packages
#always at the beginning of the code 
library(terra)
library(imageRy)
library(viridis)


#Content of the package 
im.list()     #[im.list=lists the files contained in the package]


#Sentinel-2 bands (spatial resolution = 10m) 
b2=im.import("sentinel.dolomites.b2.tif")     #[im.import=import of a file]
                                              #import from the package of the band 2 (blue) 
                                              #the image represent the mountain group of Tofane (Dolomites) in the blue wave lenght 
                                              #the yellow part of the image means that it reflects a lot of blue

#Definition of a color array
cl=colorRampPalette(c("black", "dark grey", "light grey"))(100)     #[colorRampPalette=create a palette with the indicated colors]
                                                                    #[c=concatenate function that combine three color (elements of an array)]
                                                                    #[(100)=number of colors]
plot(b2, col=cl)

cl=colorRampPalette(c("black", "dark grey", "light grey"))(3)
plot(b2, col=cl)

#EXERCISE: make your own color ramp
cl=colorRampPalette(c("purple2", "paleturquoise", "violetred1"))(100)
plot(b2, col=cl)


#band 3:verde 
b3=im.import("sentinel.dolomites.b3.tif")
#band 2:blu
b2=im.import("sentinel.dolomites.b2.tif")
#band4: rosso
b4=im.import("sentinel.dolomites.b4.tif")
#band8: infrarosso vicino 
b8=im.import("sentinel.dolomites.b8.tif")


par(mfrow=c(1,4))
b2=im.import("sentinel.dolomites.b2.tif")
b3=im.import("sentinel.dolomites.b3.tif")
b4=im.import("sentinel.dolomites.b4.tif")
b8=im.import("sentinel.dolomites.b8.tif")
#c perchè 1 e 4 sono elementi di un vettore 

par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off()

#MULTIFRAME
im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

#Exercise: plot the bands using im.multiframe() one on top of the other 
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

#riquadro
im.multiframe(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

#COLOR RAMP PALETTE
cl=colorRampPalette(c("black", "light grey"))(100)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

#stack
sent=c(b2,b3, b4, b8)
plot(sent, col=cl)

#cambio nomi 
names(sent)=c("b2blue", "b3green", "b4red", "b8NIR")
sent

plot(sent, col=cl)
plot(sent) 

names(sent)=c("b2blue", "b3green", "b4red", "b8NIR")
dev.off()
plot(sent$b8NIR)

#plottare il quarto elemento di sent
plot(sent[[4]])

# importing several bands altogether (sostituisce tutto quello fatto prima)
sentdol=im.import("sentinel.dolomites")

# importing several bands altogether (6 correlazioni)
pairs(sentdol)

#viridis 
plot(sentdol, col=viridis(100))
plot(sentdol, col=mako(100))

#Layers 
#1= blue (b2)
#2= green (b3)
#3= red (b4)
#4= NIR (b8)

#NATURAL COLORS (visualizzazione nel visibile)
im.plotRGB(sentdol, r=3, g=2, b=1)

#FALSE COLORS 
#aumento di uno e il blu è stato tolto 
#nella componente red abbiamo messo infrarosso vicino 
im.plotRGB(sentdol, r=4, g=3, b=2)

#Exercise: plot the image using the NIR ontop of the green component of the RGB scheme 
im.plotRGB(sentdol, r=2, g=4, b=3)
pairs(sentdol)

#è uguale
im.plotRGB(sentdol, r=3, g=4, b=2)

#confronto
im.multiframe(1, 2)
im.plotRGB(sentdol, r=2, g=4, b=3)
im.plotRGB(sentdol, r=3, g=4, b=2)


im.plotRGB(sentdol, r=3, g=2, b=4)
#bianco perchè riflettono molto 


