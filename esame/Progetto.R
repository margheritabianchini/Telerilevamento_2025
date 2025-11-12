# PROGETTO TELERILEVAMENTO 2025 
# FRANA DEL PIZZO CENGALO (VAL BONDASCA) - SVIZZERA 
#===================================================================================================================================================================
# METODO DI ANALISI DELLE IMMAGINI TELERILEVATE -> COMPRENSIONE DEL FENOMENO DI PIZZO CENGALO PER FUTURI EVENTI 
#===================================================================================================================================================================
# Nell'area sono stati registrati due eventi principali, in data: 
# - 27.12.2011: rock avalanche di circa 1.5-2x10^6 m^3
# - 23.08.2017: rock avalanche + debris flow 3x10^6 m^3. 'evento più rilevante si è verificato il 23.08.2017 coinvolgendo il paese di Boldo situato a valle
# Entrambi hanno raggiunto il paese di Bondo situato a valle, fino al canale del torrente principale
#===================================================================================================================================================================
# METODO 

# A. VISUALIZZAZIONE IMMAGINI: individuazione dei due eventi principali che hanno interessato l'area
#    1.Landsat 5 e Landsat 7: 2011, 2013 (evento 27.12.2011)
#      Sentinel-2: 2017, 2018 (evento 23.08.2017)
#    2.VISUALIZZAZIONE FILE PANORAMICA NORMALE, FALSI COLORI 

# -> Sentinel: 2017, 2018 (evento 23.08.2017)

# B. CALCOLO DEGLI INDICI SPETTRALI (NDVI)

# C. ANALISI MULTITEMPORALE (scatterplot, differenza NDVI)

# D. CLASSIFICAZIONE (calcolo delle percentuali, creazione degli istogrammi)

# E. VARIABILITà SPAZIALE (deviazione standard) e PCA (?)
#===================================================================================================================================================================
# ANALISI GENERALE DEGLI EVENTI DI FRANA NELL'AREA 
#===================================================================================================================================================================
#📚 Richiamo dei pacchetti installati
library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
#===================================================================================================================================================================
#🛰️ Importazione delle immagini satellitari
# LANDSAT 5 e LANDSAT 7 (risoluzione spaziale = 30 m) 
# SENTINEL-2 (risoluzione spaziale = 10 m)
# Le immagini sono state scaricate da GEE (Google Earth Engine) -> script google_ee_exam.js 

# Set della working directory
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()

# Richiamo dei file 
# Landsat (evento 27.12.2011)
cengalo2011 = rast("landsat5_2011.tif")     #landsat 5
cengalo2013 = rast("landsat8_2013.tif")     #landsat 7

# Sentinel-2 (evento 23.08.2017) 
cengalo2017 = rast("sentinel2_estate2017.tif")
cengalo2018 = rast("sentinel2_estate2018.tif")
#===================================================================================================================================================================
#👀 Visualizzazione delle immagini 

# Landsat 
plot(cengalo2011)     #landsat 5
plot(cengalo2013)     #landsat 7  

# Sentinel-2
plot(cengalo2017)
plot(cengalo2018)
#===================================================================================================================================================================
#🌄 Esportazione delle immagini

png("cengalo2011.png")
plot(cengalo2011)
dev.off()

png("cengalo2013.png")
plot(cengalo2013)
dev.off()

png("cengalo2017.png")
plot(cengalo2017)
dev.off()

png("cengalo2018.png")
plot(cengalo2018)
dev.off()
#===================================================================================================================================================================
#🌈 Visualizzazione in colori naturali
# Corrisponde alla visualizzazione nel visibile
# [im.plotRGB = combina le tre bande in una immagine RGB]

# Landsat 
im.multiframe(1,2)     #creazione di un multiframe 
im.plotRGB(cengalo2011, r=1, g=2, b=3, title="Pizzo Cengalo anno 2011")    #landsat 5
im.plotRGB(cengalo2013, r=3, g=2, b=1, title="Pizzo Cengalo anno 2013")    #landsat 7 

# Sentinel-2
im.plotRGB(cengalo2017, r=1, g=2, b=3, title="Pizzo Cengalo anno 2017")
im.plotRGB(cengalo2018, r=1, g=2, b=3, title="Pizzo Cengalo anno 2018")
#===================================================================================================================================================================
#🌄 Esportazione delle immagini

png("cengalo2011RGB.png")
im.plotRGB(cengalo2011, r=1, g=2, b=3, title="Pizzo Cengalo anno 2011")
dev.off()

png("cengalo2013RGB.png")
im.plotRGB(cengalo2013, r=3, g=2, b=1, title="Pizzo Cengalo anno 2013") 
dev.off()

png("cengalo2017RGB.png")
im.plotRGB(cengalo2017, r=1, g=2, b=3, title="Pizzo Cengalo anno 2017")
dev.off()

png("cengalo2018RGB.png")
im.plotRGB(cengalo2018, r=1, g=2, b=3, title="Pizzo Cengalo anno 2018")
dev.off()
#===================================================================================================================================================================
#🌄 Esportazione delle immagini (SE NON SERVE DA TOGLIERE!!!!!!!!!!!!!!!)

png("evento_2011RGB.png")
im.multiframe(2,1)
im.plotRGB(cengalo2011, r=1, g=2, b=3, title="Pizzo Cengalo anno 2011")
im.plotRGB(cengalo2013, r=3, g=2, b=1, title="Pizzo Cengalo anno 2013") 
dev.off()

png("evento_2017RGB.png")
im.multiframe(2,1)
im.plotRGB(cengalo2017, r=1, g=2, b=3, title="Pizzo Cengalo anno 2017")
im.plotRGB(cengalo2018, r=1, g=2, b=3, title="Pizzo Cengalo anno 2018")
dev.off()
#===================================================================================================================================================================
#👻 Visualizzazione in falsi colori
# Presentazione della banda dell'infrarosso vicino (NIR - Near InfraRed) sulla componente del rosso
# piante -> riflettono molto il NIR (valori alti)
# roccia -> riflette poco il NIR (valori bassi)
# acqua -> riflette molto pocco il NIR (valori molto bassi) 

# Landsat 
im.plotRGB(cengalo2011, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2011")     #landsat 5 
im.plotRGB(cengalo2013, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2013")     #landsat 7

# Sentinel-2
im.plotRGB(cengalo2017, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2017")
im.plotRGB(cengalo2018, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2018")
#===================================================================================================================================================================
#🌄 Esportazione delle immagini

png("cengalo2011NIR.png")
im.plotRGB(cengalo2011, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2011") 
dev.off()

png("cengalo2013NIR.png")
im.plotRGB(cengalo2013, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2013") 
dev.off()

png("cengalo2017NIR.png")
im.plotRGB(cengalo2017, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2017")
dev.off()

png("cengalo2018NIR.png")
im.plotRGB(cengalo2018, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2018")
dev.off()
#===================================================================================================================================================================
#🌄 Esportazione delle immagini (SE NON SERVE DA TOGLIERE!!!!!!!!!!!!!!!)

png("evento_2011NIR.png")
im.multiframe(2,1)
im.plotRGB(cengalo2011, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2011") 
im.plotRGB(cengalo2013, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2013") 
dev.off()

png("evento_2017NIR.png")
im.multiframe(2,1)
im.plotRGB(cengalo2017, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2017")
im.plotRGB(cengalo2018, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2018")
dev.off()
#===================================================================================================================================================================
# ANALISI DELL'EVENTO DI FRANA DEL 23.08.2017 - IMMAGINI DI SENTINEL-2 
#===================================================================================================================================================================
#🔍 Analisi dei file 

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

ndvi2017=(cengalo2017[[4]] - cengalo2017[[1]]) / (cengalo2017[[4]] + cengalo2017[[1]])     # NDVI = (NIR - red) / (NIR + red)
ndvi2018=(cengalo2018[[4]] - cengalo2018[[1]]) / (cengalo2018[[4]] + cengalo2018[[1]])     # NDVI = (NIR - red) / (NIR + red)
#===================================================================================================================================================================
#🖼️ Multiframe con gli NDVI  

im.multiframe(1,2)
plot(ndvi2017) 
plot(ndvi2018)
dev.off()
#===================================================================================================================================================================
#🌄 Esportazione delle immagini
png("ndvi.png")
im.multiframe(1,2)
plot(ndvi2017, col=inferno(100), main="Pizzo Cengalo NDVI anno 2017")
plot(ndvi2018, col=inferno(100), main="Pizzo Cengalo NDVI anno 2018")
dev.off()
#===================================================================================================================================================================
#⛓️ Concatenamento dei due NDVI 

ndvi=c(ndvi2017, ndvi2018)

# Verifica del concatenamento  
plot(ndvi[[1]])     # NDVI 2017
plot(ndvi[[2]])     # NDVI 2018
#===================================================================================================================================================================
#📈 Scatterplot

pairs(ndvi)
plot(ndvi[[1]], ndvi[[2]], xlab="NDVI 2017", ylab="NDVI 2018", main="Scatterplot NDVI")
abline(0, 1, col="red")

# asse x = NDVI 2017
# asse y = NDVI 2018 
# linea rossa -> NDVI 2017 = NDVI 2018

# dato che i punti stanno sotto la linea rossa è un segno che è stata registrata una perdita di vegetazione 
# valori alti NDVI 2017 e valori bassi NDVI 2018 (x > y)

# Diversamente, nel caso in cui: 
# - no cambiamento -> i punti sarebbero sulla linea
# - aumento vegetazione -> i punti sarebbero sopra la linea 
#===================================================================================================================================================================
#🌄 Esportazione dei grafici

png("pairsNDVI.png")
pairs(ndvi)
dev.off()

png("scatterplotNDVI.png") 
plot(ndvi[[1]], ndvi[[2]], xlab="NDVI 2017", ylab="NDVI 2018", main="Scatterplot NDVI")
abline(0, 1, col="red")
dev.off()
#===================================================================================================================================================================
#➖ Differenza tra NDVI e approfondimento analisi multitemporale oppure valutare se fare direttamente la classificazione 

diff_ndvi = ndvi[[2]] -  ndvi[[1]]     # NDVI 2018 - NDVI 2017
plot(diff_ndvi)
#===================================================================================================================================================================
#🌄 Esportazione dell'immagine

png("differenza_NDVI.png")
plot(diff_ndvi, col=inferno(100), main="Differenza NDVI (anno 2018 - anno 2017)")
dev.off()
#===================================================================================================================================================================
#✂️ Ritaglio del file della differenza tra NDVI (tipo SpatRaster)
# in questo modo è stata rimossa la porzione di raster coperta dalle nuvole

# Codice utilizzato per tagliare manualmente l'immagine
# plot(diff_ndvi)
# extent_interactive = drawExtent()     # crea e definisce manualmente il rettangolo da ritagliare
# ndvi_diff_crop = crop(diff_ndvi, extent_interactive)     # ritaglia lo SpatRaster secondo l'extent selezionato 
# plot(ndvi_diff_crop, main="Differenza NDVI ritagliato (anno 2018 - anno 2017)")    # visualizzazione del risultato 
# writeRaster(ndvi_diff_crop, "ndvi_diff_crop.tif", overwrite=TRUE)    # salvataggio del file ritagliato

# Confronto del file originale e il file ritagliato
plot(diff_ndvi)
plot(ndvi_diff_crop)
#===================================================================================================================================================================
#🎨 Classificazione della differenza ritagliata tra gli NDVI -> determinazione della percentuale di sedimento mobilizzato

cengaloc = im.classify(ndvi_diff_crop, num_clusters=2)
# classe 1 = area invariata 
# classe 2 = detrito mobilizzato  
#===================================================================================================================================================================
#🌄 Esportazione dell'immagine

png("classify_diffNDVI_crop.png")
levels(cengaloc) = data.frame(ID = c(1,2), Classe = c("No\nvariato", "Detrito"))
plot(cengaloc, main="Classificazione differenza NDVI")
dev.off()
#===================================================================================================================================================================
#📱 Analisi statistica 

# Calcolo della frequenza e del totale 
# Frequenza
freq_cengalo = freq(cengaloc)     # calcolo della frequenza dei valori dei pixel che compongono il raster classificato dell'area studiata  
# Numero di celle 
tot_cengalo = ncell(cengaloc)     # calcolo del numero totale di pixel 

# Calcolo della proporzione e percentuale delle classi 
# Proporzione
prop_cengalo = freq_cengalo$count / tot_cengalo    # prop = (freq / tot)
#Verifica dei valori calcolati
freq_cengalo 
# Percentuale
perc_cengalo = prop_cengalo * 100     # perc = (freq / tot) * 100
perc_cengalo 
#===================================================================================================================================================================
# 📅 Rappresentazione dei dati in tabella

classi = c("Area invariata", "Detrito mobilizzato")     # definizione delle classi 
percentuale = c(98,2)    # colonna di valori
tabdetrito = data.frame(classi, percentuale)
#===================================================================================================================================================================
#📊 Rappresentazione dei dati come istogrammi 

p1 = ggplot(tabdetrito, aes(x=classi, y=percentuale, color=classi, fill=classi)) +  
  geom_bar(stat="identity") + 
   labs(title = "Impatto dell'evento 23.08.2017") +
  theme(
    plot.title = element_text(
      face = "bold",    # grassetto
      hjust = 0.5)) +
  ylim(c(0,100))
#===================================================================================================================================================================
#🌄 Esportazione del grafico 

png("p1_tabdetrito.png")
plot(p1)
dev.off()













