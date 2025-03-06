# R code for visualizing satellite data

#PACCHETTI SEMPRE ALL'INIZIO
#install.packages("viridis")

library(terra)
library(imageRy)
library(viridis)

im.list()
#Sentinel-2 bands 
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

