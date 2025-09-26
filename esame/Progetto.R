#PROGETTO TELERILEVAMENTO 2025 
#FRANA DI PIZZO CENGALO (VAL BONDASCA)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#📚Richiamo dei pacchetti installati 
library(terra)
library(imageRy)
library(viridis) 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#🛰️Importazione delle immagini satellitari della missione SENTINEL-2 
#  (risoluzione spaziale = 10 m)
#  Le immagini sono state scaricate da GEE (Google Earth Engine)

#Set della working directory 
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()
pizzo_cengalo = rast(pizzo_cengalo_2017_08.tif)
