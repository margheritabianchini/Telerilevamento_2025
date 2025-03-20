#R code for performing multitemporal analysis 
#è analizzata la distribuzione multitemporale dell'NO3 nel tempo

install.packages("ggridges") #this is needed to create ridgeline plots 
library(imageRy)
library(terra)
library(viridis)
# library(ggridges)



#Listing the data 
im.list()

EN_01=im.import("EN_01.png")
EN_01=flip(EN_01)
plot(EN_01)
#immagine gennaio 2020

#è un'immagine RGB in raimbow colors (i colori in questo caso non vanno bene)
#zone in cui il traffico veicolare è maggiore hanno valori più alti 

EN_13=im.import("EN_13.png")
EN_13=flip(EN_13)
plot(EN_13)
#nell'immagine di marzo 2020
#si vede che gli spot sono molto diminuiti

#Exercise: plot the two images one beside the other
im.multiframe(1,2)
plot(EN_01)
plot(EN_13)


#differenza tra le due immagini (gennaio-marzo)
ENdif = EN_01[[1]] - EN_13[[1]] 
plot(ENdif)

#differenza (giallo) -> spostati verso gennaio
#differenza inversa (blu) -> spostati verso marzo -> aree in cui sono rimasti alti i valori o addirittura maggiori 

#plot con colore inferno di viridis
plot(ENdif, col=inferno(100))

#--------



#Greenland dataset ice melt
#in base alla temperatura 
#le temperature più basse si concentrano al centro 

gr=im.import("greenland")
im.multiframe(1,2) 
plot(gr[[1]], col=rocket(100))
plot(gr[[4]], col=rocket(100))

#in questo caso si possono individuare anche delle fluttuazioni e non un cambiamento climatico reale

grdif = gr[[1]] - gr[[4]] 
dev.off()
plot(grdif)

#la parte blu sono più alti valori di temperatura nel 2015


#RIDGELINE PLOTS: utile per analizare la distribuzione (es. frequenza)
im.ridgeline(gr, scale=1)
# in questo caso è difficile trovare un trend ma sono fluttuazioni
# prende tutti i pixel e calcola le frequenze dei pixel

# invece di rimanere nella propria parte di grafico va a sovrapporsi a quello successivo

im.ridgeline(gr, scale=2)
im.ridgeline(gr, scale=2, palette="inferno")
#in questo modo cambia il colore del grafico 


im.ridgeline(gr, scale=3, palette="inferno")

#Exercise: import the NDVI data
ndvi=im.import("Sentinel2_NDVI")
#è il gruppo del brenta
# dato che i nomi sono uguali lui è anadato a sovrascriverli

# Changing names 
# Sources:    Sentinel2_NDVI_2020-02-21.tif  
              Sentinel2_NDVI_2020-05-21.tif  
              Sentinel2_NDVI_2020-08-01.tif  
              Sentinel2_NDVI_2020-11-27.tif  
# come rinominare colonne di un dataframe 
names(ndvi) = c("02_Feb", "05_May", "08_Aug", "11_Nov")
im.ridgeline(ndvi, scale=2)

# tutte le volte che c'è un problema grafico -> dev.off 

plot(ndvi)
im.ridgeline(ndvi, scale=2)
im.ridgeline(ndvi, scale=2, palette="mako")

# avrà valori più bassi dato i valori inferiori di biomassa per il periodo dell'anno
# aumentano fino a agosto_settembre
# si torna alla situazione precedente a novembre


pairs(ndvi)
plot(ndvi[[1]], ndvi[[2]])
# y = x #may y, feb x 
# y = a + bx 
# a = 0, b = 1 
# y = a + bx = 0 + 1x = x

# linea 1 a 1 
abline(0, 1, col="red")

# mettiamo i dataset con lo stesso range
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")

# se sta sopra i dati sono superiori a maggio rispetto a febbraio
im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]], ndvi[[2]], xlim=c(-0.3, 0.9), ylim=c(-0.3, 0.9))
abline(0, 1, col="red")

