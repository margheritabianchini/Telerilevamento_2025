#CODE TO CALCULTATE SPECTRAL INDICES FROM SATELLITE IMAGES 


#Packages 
library(imageRy) # beloved package developed at unibo
library(terra)
library(viridis)


#Content of the package 
im.list()


#MATO GROSSO 1992 ------------------------------------------------------------------------------------------------------------------------------------------------
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)     #[flip=flips the object]


#Layers (bands) 
#1= NIR                  
#2 = red
#3 = green
#the order of the layers depends on how it was created
#this order was set manually


im.plotRGB(mato1992, r=1, g=2, b=3)     #to better see the differentiation of objects
                                        #the flipped image will be displayed only after the plot


im.plotRGB(mato1992, r=2, g=1, b=3)     #green component


im.plotRGB(mato1992, r=2, g=3, b=1)     #NIR on the blue band 
                                        #the difference between the bare soil and the rest of the elements is clear (yellow bare soil)


#MATO GROSSO 2006 -------------------------------------------------------------------------------------------------------------------------------------------------
mato2006= im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006=flip(mato2006)
plot(mato2006)


#🖼️ Multiframe 
im.multiframe(1, 2)
im.plotRGB(mato1992, r=2, g=3, b=1, title="Matogrosso 1992")     #[title=allows the insertion of a title above the plot]
im.plotRGB(mato2006, r=2, g=3, b=1, title="Matogrosso 2006")     #on the left the water is not black because there are a lot of dissolved solids


#Radiometric resolution 
plot(mato1992[[1]], col=inferno(100))     #[[1]] = plot only the first layer of mato1992, so only the NIR band
plot(mato2006[[1]], col=inferno(100))     #[[1]] = plot only the first layer of mato1992, so only the NIR band


#DVI (Difference Vegetation Index) --------------------------------------------------------------------------------------------------------------------------------
#healthy vegetation    -> maximum reflectance of NIR 
                       -> minimum reflectance of red (it is absorbed to carry out photosynthesis)
#🌳TREE: NIR=255, red=0, DVI=NIR-red=255

#stressed vegetation   -> highest red reflectance (the palisade cells collapse so it will not absorb as much as when it is healthy)
#🌳💀STRESSED TREE: NIR=100, red=20, DIV=NIR-red=80

#Layers (bands)
#1 = NIR 
#2 = red 

#Calculate DVI for 1992
dvi1992= mato1992[[1]] - mato1992[[2]]     #difference NIR - red
plot(dvi1992)                              #calculated difference plot
plot(dvi1992, col=inferno(100))            #color change

#Range DVI 
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

#Calculate DVI for 2006 
dvi2006= mato2006[[1]] - mato2006[[2]]     #NIR - red
plot(dvi2006)
plot(dvi2006, col=inferno(100)) 

#🖼️ Multiframe with the two DVI 
im.multiframe(1,2)
plot(dvi1992, col=inferno(100)) 
plot(dvi2006, col=inferno(100))


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Different radiometric resolutions 
#DVI 8 bit:range (0-255)
# maximum: NIR - red = 255 - 0 = 255
# minimum: NIR - red = 0 - 255 = -255

#DVI 4 bit: range (0-15)
# maximum: NIR - red = 15 - 0 = 15
# minimum: NIR - red = 0 - 15 = -15

#the range is different, so a comparison between a 4-bit image and an 8-bit image is not possible
#to solve this problem NDVI is used
#calculate the difference between NIR and red and standardize it
#----------------------------------------------------------------------------------------------------------------------------------------------------------------

#Range NDVI 
#NDVI 8 bit: range (0-255)
# maximum: (NIR - red)/(NIR + red) = (255-0)/(255 + 0) =1 
# minimum: (NIR - red)/(NIR + red) = (0 - 255)/(0 + 255) = -1 

#NDVI 4 bit: range (0-15)
# maximum: (NIR - red)/(NIR + red) = (15-0)/(15 + 0) = 1 
# minimum: (NIR - red)/(NIR + red) = (0 - 15)/(0 + 15 = -1 

# NDVI 3 bit: range (0-7)
# maximum: (NIR - red)/(NIR + red) = (7-0)/(7 + 0) = 1 
# minimum: (NIR - red)/(NIR + red) = (0 - 7)/(0 + 7) = -1 

#NDVI 1992 independent of incoming radiometric radiation
ndvi1992 = (mato1992[[1]] - mato1992[[2]]) / (mato1992[[1]] + mato1992[[2]])     #(NIR-red)/(NIR+red)
#or otherwise...ndvi1992= dvi1992/(mato1992[[1]] + mato1992[[2]])
plot(ndvi1992)

# the two images have the same original radiometric radiation so there is no difference
# it is usually used with different radiometric radiations

#NDVI 2006 
ndvi2006 = (mato2006[[1]] - mato2006[[2]]) / (mato2006[[1]] + mato2006[[2]])     #(NIR-red)/(NIR+red)
#or otherwise...ndvi2006= dvi2006/(mato2006[[1]] + mato2006[[2]])
plot(ndvi2006)


#Functions from imageRy (automatic DVI and NDVI) ------------------------------------------------------------------------------------------------------------------
dvi1992auto = im.dvi(mato1992, 1, 2)     #[im.dvi=calculate the value of the DVI]
dev.off ()
plot(dvi1992auto)

ndvi1992auto = im.ndvi(mato1992, 1, 2)     #[im.ndvi=calculate the value of the NDVI]
dev.off ()
plot(ndvi1992auto)

dvi2006auto = im.dvi (mato2006, 1, 2)
dev.off ()
plot(dvi2006auto)

ndvi2006auto = im.ndvi(mato2006, 1, 2)
dev.off ()
plot(ndvi2006auto)


#🖼️ Multiframe with the two NDVI (classic and automatic) 
im.multiframe (1,2)
plot(ndvi1992)
plot(ndvi1992auto)

# high values -> vegetation (yellow part)
# low values -> deforestation, water, rocks, bare soil (blue part)
