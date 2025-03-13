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


#1 = NIR 
#2 = red 

dvi1992= mato1992[[1]] - mato1992[[2]] #NIR - red
plot(dvi1992)

# range DVI 
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

plot(dvi1992, col=inferno(100)) 


#Calculate dvi for 2006 
# avendo le bande associo semplicemente i dati 
dvi2006= mato2006[[1]] - mato2006[[2]] #NIR - red
plot(dvi2006)
plot(dvi2006, col=inferno(100)) # cambio di colore

im.multiframe(1,2)
plot(dvi1992, col=inferno(100)) 
plot(dvi2006, col=inferno(100))



#Different radiometric resolutions

#DVI 8 bit:range (0-255)
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

#DVI 4 bit: range (0-15)
# maximum: NIR - red = 15 - 0 = 15
# minimum: NIR - red = 0 - 15 = -15

#se io ho un immagine a 4 bit e una a 8 bit non sono paragonabili
#perchè hanno un range diverso
#per risolvere questo problema è usato NDVI
#fa la differenza tra NIR e red e lo standarderizzazione


# NDVI 8 bit: range (0-255)
# maximum: (NIR - red) / (NIR + red) = (255-0) / (255 + 0) =1 
# minimum: (NIR - red)/ (NIR + red) = (0 - 255)/ (0 + 255)= -1 

# NDVI 4 bit: range (0-15)
# maximum: (NIR - red) / (NIR + red) = (15-0) / (15 + 0) =1 
# minimum: (NIR - red)/ (NIR + red) = (0 - 15)/ (0 + 15)= -1 

# NDVI 3 bit: range (0-7)
# maximum: (NIR - red) / (NIR + red) = (7-0) / (7 + 0) =1 
# minimum: (NIR - red)/ (NIR + red) = (0 - 7)/ (0 + 7)= -1 

#NDVI svincolato dalla radiazione radiometrica in entrata 

ndvi1992 = (mato1992[[1]] - mato1992[[2]]) / (mato1992[[1]] + mato1992[[2]])
# ndvi1992= dvi1992/(mato1992[[1]] + mato1992[[2]])
plot(ndvi1992)
# le due immagini hanno radiazione radiometrica originale uguale quindi non c'è differenza
# ma in generale è utilizzato con radiazioni radiometriche diverse 

ndvi2006 = (mato2006[[1]] - mato2006[[2]]) / (mato2006[[1]] + mato2006[[2]])
# ndvi2006= dvi2006/(mato2006[[1]] + mato2006[[2]])
plot(ndvi2006)

#Functions from imageRy
dvi1992auto = im.dvi(mato1992, 1, 2)
dev.off ()
plot(dvi1992auto)

ndvi2006auto = im.ndvi (mato2006, 1, 2)
dev.off ()
plot(ndvi2006auto)

dvi1992auto = im.ndvi(mato1992, 1, 2)
dev.off ()
plot(ndvi1992auto)

dvi1992auto = im.ndvi(mato1992, 1, 2)
dev.off
plot(ndvi1992auto)

im.multiframe (1,2)
plot(ndvi1992)
plot(ndvi1992auto)

# google engine 
# parti chiare è dove non c'è più foresta 
# ndvi mostrano le dove è deforestato o meno (giallo dove c'è ancora foresta)
