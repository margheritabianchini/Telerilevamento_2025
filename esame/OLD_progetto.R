#📚Richiamo dei pacchetti installati
library(terra)
library(imageRy)
library(viridis) 
#===================================================================================================================================================================
#🛰️Importazione delle immagini satellitari della missione SENTINEL-2 
# (risoluzione spaziale = 10 m)
# Le immagini sono state scaricate da GEE (Google Earth Engine)

# Set della working directory
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()

# Richiamo dei file 
#Landsat 5 (evento 27.12.2011)
pizzo_cengalo_2011 = rast("L5_2011.tif") 
#===================================================================================================================================================================
#👀Visualizzazione delle immagini 

# Plot delle due immagini 
# Landsat 5
plot(pizzo_cengalo_2011)

# Visualizzazione in colori naturali
# Corrisponde alla visualizzazione nel visibile
# [im.plotRGB = combina le tre bande in una immagine RGB]
# Landsat 5 
im.plotRGB(pizzo_cengalo_2011, r=1, g=2, b=3)


