# PROGETTO TELERILEVAMENTO 2025 
# FRANA DEL PIZZO CENGALO (VAL BONDASCA) - SVIZZERA 
# L'evento si è verificato il 23.08.2017 coinvolgendo il paese di Boldo situato a valle

# METODO DI ANALISI DELLE IMMAGINI TELERILEVATE - COMPRENSIONE DEL FENOMENO DI PIZZO CENGALO PER FUTURI FENOMENI

# A. VISUALIZZAZIONE IMMAGINI: individuazione dei due eventi principali che hanno interessato l'area
#    1.Landsat 5 e Landsat 7: 2011, 2013 (evento 27.12.2011)
#      Sentinel-2: 2017, 2018 (evento 23.08.2017)
#    2.VISUALIZZAZIONE FILE PANORAMICA NORMALE, FALSI COLORI 

# -> Sentinel: 2017, 2018 (evento 23.08.2017)

# B. CALCOLO DEGLI INDICI SPETTRALI (NDVI, scatterplot (?))

# C. ANALISI MULTITEMPORALE (differenza tra gli anni e ndvi, ridgeline plot, scatterplot)

# D. CLASSIFICAZIONE (calcolo delle percentuali, creazione degli istogrammi)

# E. VARIABILITà SPAZIALE (deviazione standard) e PCA (?)

#===================================================================================================================================================================
#📚 Richiamo dei pacchetti installati
library(terra)
library(imageRy)
library(viridis) 
#===================================================================================================================================================================
#🛰️ Importazione delle immagini satellitari della missione SENTINEL-2 
# (risoluzione spaziale = 10 m)
# Le immagini sono state scaricate da GEE (Google Earth Engine)

# Set della working directory
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()

# Richiamo dei file 
# Landsat 5 (evento 27.12.2011)
cengalo2011 = rast("landsat5_2011.tif")
cengalo2013 = rast("landsat8_2013.tif")
# Sentinel-2 (evento 23.08.2017) 
cengalo2017 = rast("sentinel2_estate2017.tif")
cengalo2018 = rast("sentinel2_estate2018.tif")
#===================================================================================================================================================================
#👀 Visualizzazione delle immagini 
# Landsat 
plot(cengalo2011)    #landsat 5
plot(cengalo2013)    #landsat 7 
im.multiframe (1,2)

# Sentinel-2
plot(cengalo2017)
plot(cengalo2018)
#===================================================================================================================================================================
#🌈 Visualizzazione in colori naturali
# Corrisponde alla visualizzazione nel visibile
# [im.plotRGB = combina le tre bande in una immagine RGB]
# Landsat 
im.plotRGB(cengalo2011, r=1, g=2, b=3)    #landsat 5
im.plotRGB(cengalo2013, r=3, g=2, b=1)    #landsat 7 

# Sentinel-2
im.plotRGB(cengalo2017, r=1, g=2, b=3)
im.plotRGB(cengalo2018, r=1, g=2, b=3)
#===================================================================================================================================================================
#👻 Visualizzazione in falsi colori
# Presentazione della banda dell'infrarosso vicino (NIR - Near InfraRed) sulla componente del rosso
# piante -> riflettono molto il NIR (valori alti)
# roccia -> riflette poco il NIR (valori bassi)
# acqua -> riflette molto pocco il NIR (valori molto bassi) 

# Landsat 5
im.plotRGB(cengalo2011, r=4, g=3, b=2)
im.plotRGB(cengalo2013, r=4, g=3, b=2)
# Sentinel-2
im.plotRGB(cengalo2017, r=4, g=3, b=2)
im.plotRGB(cengalo2018, r=4, g=3, b=2)
#===================================================================================================================================================================
# Analisi dei file 
cengalo2017 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)

cengalo2018 
# Layers (bande)
# 1 = red (b4)
# 2 = green (b3)
# 3 = blue (b2)
# 4 = NIR (b8)
#===================================================================================================================================================================
#🌳 Calcolo dell'NDVI (Normal Difference Vegetation Index)
ndvi2017=(cengalo2017[[4]] - cengalo2017[[1]]) / (cengalo2017[[4]] + cengalo2017[[1]])
ndvi2018=(cengalo2018[[4]] - cengalo2018[[1]]) / (cengalo2018[[4]] + cengalo2018[[1]])

plot(ndvi2017)
plot(ndvi2018)
#===================================================================================================================================================================
#🖼️ Multiframe con gli NDVI  
im.multiframe(1,2)
plot(ndvi2017, col=inferno(100)) 
plot(ndvi2018, col=inferno(100))
dev.off()
#===================================================================================================================================================================
#⛓️ Concatenamento dei due NDVI 
ndvi=c(ndvi2017, ndvi2018)

# Verifica dell'operazione 
plot(ndvi[[1]]) 
plot(ndvi[[2]])
#===================================================================================================================================================================
#📈 Scatterplots
pairs(ndvi)
plot(ndvi[[1]], ndvi[[2]])
abline(0, 1, col="red")

# asse x = NDVI 2017 
# asse y = NDVI 2018 
# linea -> NDVI 2017= NDVI 2018

# dato che i punti stanno sotto la linea rossa è un segno che è stata registrata una perdita di vegetazione 
# valori alti NDVI 2017 e valori bassi NDVI 2018 (x > y)

# Diversamente, nel caso in cui: 
# - no cambiamento -> i punti sarebbero sulla linea
# - aumento vegetazione -> i punti sarebbero sopra la linea 

# export del grafico 
#===================================================================================================================================================================
# Differenza tra NDVI e approfondimento analisi multitemporale oppure valutare se fare direttamente la classificazione 
diff_ndvi = ndvi[[2]] -  ndvi [[1]] # ndvi2018 - ndvi2017


