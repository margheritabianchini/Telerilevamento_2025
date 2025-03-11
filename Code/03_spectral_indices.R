#Code to calculate spectral indices from satellite images 

library(imageRy) # beloved package developed at unibo
library(terra)
library(viridis)

im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
#1= NIR
#2 = red
#3 = green 

#per vedere meglio la differenziazione tra gli oggetti 
im.plotRGB(mato1992, r=1, g=2, b=3) 

#componente green
im.plotRGB(mato1992, r=2, g=1, b=3) 

#il NIR va sul blu
#si vede bene la differenza tra suolo nudo e resto (suolo nudo giallo)
im.plotRGB(mato1992, r=2, g=3, b=1) 


#Import the 2006 image of the Mato Grosso area 
mato2006= im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006=flip(mato2006)
plot(mato2006)

im.multiframe(1, 2)
im.plotRGB(mato1992, r=2, g=3, b=1, title="Matogrosso 1992")
im.plotRGB(mato2006, r=2, g=3, b=1, title="Matogrosso 2006")

#radiometric resolution 
plot(mato1992[[1]], col=inferno(100))
plot(mato2006[[1]], col=inferno(100))

#DVI
#vegetazione in salute avrà riflettanza max 
#in rosso assorbe per fare fotosintesi 
#se non in salute le cellule a palizzata collassano quindi non assorbirà più come quando sta bene 
#Tree: NIR=255, red=0, DVI=NIR-red=255
#Stressed tree: NIR=100, red=20, DIV=NIR-red=80




