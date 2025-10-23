#PROGETTO TELERILEVAMENTO 2025 
#FRANA DEL PIZZO CENGALO (VAL BONDASCA) - SVIZZERA 
#L'evento si è verificato il 23.08.2017 coinvolgendo il paese di Boldo situato a valle
#===================================================================================================================================================================
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
pizzo_cengalo_pre = rast("sentinel2_estate2017.tif")
pizzo_cengalo_post = rast("sentinel2_estate2018.tif")
#===================================================================================================================================================================
#👀Visualizzazione delle immagini 

# Analisi dei file 
# pizzo_cengalo_pre 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)

pizzo_cengalo_post 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)

# Plot delle due immagini 
plot(pizzo_cengalo_pre)
plot(pizzo_cengalo_post)

# Colori naturali
im.plotRGB(pizzo_cengalo_pre, r=1, g=2, b=3)
im.plotRGB(pizzo_cengalo_post, r=1, g=2, b=3)



