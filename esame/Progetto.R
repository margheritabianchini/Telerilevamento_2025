# PROGETTO TELERILEVAMENTO 2025 
# FRANA DEL PIZZO CENGALO (VAL BONDASCA) - SVIZZERA 
# L'evento si è verificato il 23.08.2017 coinvolgendo il paese di Boldo situato a valle

#METODO DI ANALISI DELLE IMMAGINI TELERILEVATE - COMPRENSIONE DEL FENOMENO DI PIZZO CENGALO PER FUTURI FENOMENI

# A. VISUALIZZAZIONE IMMAGINI: individuazione dei due eventi principali che hanno interessato l'area
#    1.Landsat: pre 2011, post 2011 (evento 27.12.2011)
#      Sentinel: 2017, 2018 (evento 23.08.2017)
#    2.VISUALIZZAZIONE FILE PANORAMICA NORMALE, FALSI COLORI 

# -> Sentinel: 2017, 2018 (evento 23.08.2017)

# B. CALCOLO DEGLI INDICI SPETTRALI (NDVI, scatterplot (?))

# C. ANALISI MULTITEMPORALE (differenza tra gli anni e ndvi, ridgeline plot, scatterplot)

# D. CLASSIFICAZIONE (calcolo delle percentuali, creazione degli istogrammi)

# E. VARIABILITà SPAZIALE (deviazione standard) e PCA (?)

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
#Landsat 5 (evento 27.12.2011)
pizzo_cengalo_2011 = rast("landsat5_2011.tif")
#Sentinel-2 (evento 23.08.2017) 
pizzo_cengalo_primavera2017 = rast("sentinel2_primavera2017.tif")
pizzo_cengalo_pre2017 = rast("sentinel2_pre_pre_evento.tif")
pizzo_cengalo_2017 = rast("sentinel2_estate2017.tif")
pizzo_cengalo_2018 = rast("sentinel2_estate2018.tif")
pizzo_cengalo_pre2017 = rast("sentinel2_pre_pre_evento.tif") 
#===================================================================================================================================================================
#👀Visualizzazione delle immagini 

# Analisi dei file 
pizzo_cengalo_2017 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)

pizzo_cengalo_2018 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)

# Plot delle due immagini 
# Landsat 5
plot(pizzo_cengalo_2011)
# Sentinel-2
plot(pizzo_cengalo_primavera2017)
plot(pizzo_cengalo_pre2017)
plot(pizzo_cengalo_2017)
plot(pizzo_cengalo_2018)

# Visualizzazione in colori naturali
# Corrisponde alla visualizzazione nel visibile
# [im.plotRGB = combina le tre bande in una immagine RGB]
# Landsat 5 
im.plotRGB(pizzo_cengalo_2011, r=1, g=2, b=3)
# Sentinel-2
im.plotRGB(pizzo_cengalo_primavera2017, r=1, g=2, b=3)
im.plotRGB(pizzo_cengalo_pre2017, r=1, g=2, b=3)
im.plotRGB(pizzo_cengalo_2017, r=1, g=2, b=3)
im.plotRGB(pizzo_cengalo_2018, r=1, g=2, b=3)


# Visualizzazione in falsi colori
# Presentazione della banda dell'infrarosso vicino (NIR - Near InfraRed) sulla componente del rosso
# piante -> riflettono molto il NIR (valori alti)
# roccia 
im.plotRGB(pizzo_cengalo_2017, r=4, g=3, b=2)



