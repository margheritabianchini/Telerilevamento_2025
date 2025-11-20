> #### Margherita Bianchini
> ## PROGETTO DI TELERILEVAMENTO GEO-ECOLOGICO IN R - A.A. 2024/2025
> #### Corso di Laurea Magistrale in Geologia e Territorio (LM-74)

------------------
# Caso di studio della frana di Pizzo Cengalo (Val Bondasca, Svizzera)

## Indice 
1. Introduzione
2. Dati
3. Visualizzazione degli eventi franosi principali 
4. Analisi dell'evento del 23.08.2017
   
   4.1 NDVI (Normalized Difference Vegetation Index) 
   
   4.2 Variabilità spaziale
   
   4.3 Analisi multitemporale
   
   4.4 Classificazione
6. Discussione
7. Conclusioni
Bibliografia

## 1. Introduzione 
La mattina del 23 agosto 2017, nella località di Bregaglia (Val Bondasca, Svizzera), un volume di circa 3 x 10<sup>6</sup> m<sup>3</sup> si è distaccato dalla parete nord-est del Pizzo Cengalo (3368 m s.l.m.), innescando un **fenomeno franoso** che in pochi minuti ha raggiunto l'abitato di Bondo a valle.

![area_studio](https://github.com/user-attachments/assets/69e65690-1888-4ff6-84e4-825944e47463)
***Figura 1.** Inquadramento geografico dell'area di studio (Pizzo Cengalo, Svizzera).*

Il Pizzo Cengalo è caratterizzato da una ripida parete nord-orientale, altamente fratturata, che è stata ripetutamente oggetto di altri eventi franosi simili. Su tale versante si sviluppa il ghiacciaio che si collega alla Val Bondasca e che nel tempo si è progressivamente ritirato fino a giungere alla base della parete rocciosa. 
Il **primo evento** è avvenuto il **27 dicembre 2011**, dal volume di circa 1.5-2 x 10<sup>6</sup> m<sup>3</sup>, si è esteso per circa 1,5 km lungo la Val Bondasca (Haeberli, 2013; Amann et al., 2018). Successivamente, nel mese di agosto del 2017, è stato rilevato un incremento dei crolli e dei tassi di deformazione, a cui si è seguito l'evento principale del **23 agosto 2017**. 
Quest'ultimo evento franoso si è sviluppato in più fasi:
- **I° FASE:** distacco iniziale dal ghiacciaio
- **II° FASE:** rock avalanche
- **III° FASE:** debris flow

![evento2017](https://github.com/user-attachments/assets/a72da3a1-8fe7-4073-9782-bf807e5b150a)

***Figura 2.** Rappresentazione 3D della frana del 2017 riportata nel lavoro di Mergili et al. 2020.*

Nel presente progetto sono presentati i principali eventi franosi che sono stati registrati nell'area del Pizzo Cengalo. Per l'evento del 23 agosto 2017 è stata svolta un'anilisi più dettagliata sullo scenario pre e post frana, basata su:  
- ***variabilità spaziale***
- ***indice spettrale (NDVI)***
- ***analisi multitemporale***
- ***impatto del fenomeno nell'area***
In questo modo è stato valutato l'impatto dell'evento in funzione dell'*area coinvolta*, del *volume mobilizzato* e dei *cambiamenti morfologici*, al fine di fornire delle informazioni fondamentali nel **monitoraggio** delle zone suscettibili e nella la **gestione di futuri eventi franosi** di questa tipologia (es. frana di Blatten)

## 2. Dati 
Le immagini satellitari sono state scaricate da [Google Earth Engine](https://earthengine.google.com/). 


***Tabella 1.** Immagini satellitari utilizzate nell'analisi.*

  |MISSIONI|         |EVENTO|ARCO TEMPORALE|                 
  |--------|--------|---------|-------|
  |**Landsat**|*Landsat 5*|pre-evento|1.05.2011 - 1.09.2011|
  |        |*Landsat 8*|post-evento|1.05.2013 - 1.10.2013|
  |**Sentinel**|*Sentinel-2*|pre-evento|23.06.2017 - 23.08.2017|
  |||post-evento|2.06.2018 - 23.08.2018|

L'analisi è stata svolta usando il **software R**, utilizzando i seguenti pacchetti: 
``` r
library(terra)      # analisi delle immagini satellitari (raster)
library(imageRy)    # visualizzazione delle immagini satellitari  
library(viridis)    # editing delle palette di colori 
library(ggplot2)    # creazione dei grafici
```

## 3. Visualizzazione degli eventi franosi principali
Per prima cosa è stata impostata la working directory. 
``` r
# Set della working directory
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()
```

Sono state richiamate, visualizzate ed esportate come file `.pgn` le immagini satellitari dei due relativi eventi:

***-> Evento 2011*** 
``` r
# Richiamo dei file
cengalo2011 = rast("landsat5_2011.tif")    # Landsat 5
cengalo2013 = rast("landsat8_2013.tif")    # Landsat 7

# Visualizzazione
plot(cengalo2011)                          # Landsat 5
plot(cengalo2013)                          # Landsat 7
```
![cengalo_2011](https://github.com/user-attachments/assets/c4cb1b61-e371-4bd9-80bf-e7c87fe9523c)


***Figura 3.** Area del Pizzo Cengalo nell'estate del 2011.*

![cengalo_2013](https://github.com/user-attachments/assets/31345822-815d-4d8d-bf08-a09c124480a4)

***Figura 4.** Area del Pizzo Cengalo nell'estate del 2013.*

***-> Evento 2017*** 
``` r
# Richiamo dei file (evento 2017)
cengalo2017 = rast("sentinel2_estate2017.tif")    # Sentinel-2
cengalo2018 = rast("sentinel2_estate2018.tif")    # Sentinel-2

# Visualizzazione 
plot(cengalo2017)                                 # Sentinel-2
plot(cengalo2018)                                 # Sentinel-2 
```
![cengalo_2017](https://github.com/user-attachments/assets/5a174782-2c61-4264-b5c7-aac5a565332a)

***Figura 5.** Area del Pizzo Cengalo nell'estate del 2017 (pre-evento).*


![cengalo_2018](https://github.com/user-attachments/assets/290b1393-4e01-48d0-8fb2-f55b8494cda9)

***Figura 6.** Area del Pizzo Cengalo nell'estate del 2018.*

--------
>[!NOTE]
> Ogni immagine presente in questo lavoro è stata esportata utilizzando la sequenza di funzioni di R:
>
>`png("immagine.png")`
>
>`plot(immagine)`
>
>`dev.off()`
-----------

Le immagini sono state rappresentate nello **spettro visibile** con la funzione `im.plotRGB` che combina le tre bande in un'immagine RGB: 

***-> Evento 2011*** 
``` r
im.multiframe(1,2)                                                         # creazione di un multiframe 
im.plotRGB(cengalo2011, r=1, g=2, b=3, title="Pizzo Cengalo anno 2011")    # Landsat 5
im.plotRGB(cengalo2013, r=3, g=2, b=1, title="Pizzo Cengalo anno 2013")    # Landsat 7 
```
> [!TIP]
> L'immagine acquisita del satellite Landsat 7 è stata calibrata diversamente dalle altre dato che ha una diversa combinazione delle bande. 
>
> 
![evento2011_RGB](https://github.com/user-attachments/assets/69fe2465-e9ff-48db-b471-0bae86626786)

***Figura 7.** Rappresentazione dell'evento del 2011 nello spettro visibile.*

***-> Evento 2017*** 
``` r
im.plotRGB(cengalo2017, r=1, g=2, b=3, title="Pizzo Cengalo anno 2017")   # Sentinel-2
im.plotRGB(cengalo2018, r=1, g=2, b=3, title="Pizzo Cengalo anno 2018")   # Sentinel-2
dev.off()                                                                 # chiusura del multiframe 
```
![evento2017_RGB](https://github.com/user-attachments/assets/aa821a02-b911-43d3-91fc-30f5d5a6df19)

***Figura 8.** Rappresentazione dell'evento del 2017 nello spettro visibile.*

---------
Successivamente, sono state visualizzate in **falsi colori**, ponendo la banda dell'infrarosso vicino (NIR) sulla componente del rosso.
In questo si differenziano i vari elementi di un'immagine: 
- piante: riflettanza NIR molto alta 
- roccia: riflettanza NIR bassa 
- acqua: riflettanza NIR molto bassa

***-> Evento 2011*** 
``` r
im.plotRGB(cengalo2011, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2011")     # Landsat 5 
im.plotRGB(cengalo2013, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2013")     # Landsat 7
```
![evento2011_NIR](https://github.com/user-attachments/assets/25deed85-0705-4122-bf54-eb5ed35ffa65)

***Figura 9.** Visualizzazione dell'evento del 2011 in falsi colori.*

***-> Evento 2017*** 
``` r
im.plotRGB(cengalo2017, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2017")     # Sentinel-2
im.plotRGB(cengalo2018, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2018")     # Sentinel-2 
```
![evento2017_NIR](https://github.com/user-attachments/assets/003db99a-bb6e-44d0-929e-7f6f1eee20ea)

***Figura 10.** Visualizzazione dell'evento del 2017 in falsi colori.*

---------
## 4. Analisi dell'evento del 23.08.2017
### 4.1 NDVI (Normalized Difference Vegetation Index)
Prima di tutto è stata considerata la combinazione delle bande delle immagini satellitari richiamando il file del pre-frana e post-frana
``` r
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
```
L'**NDVI (Normalized Difference Vegetation Index)** è un indice spettrale utile per valutare lo stato della vegetazione e monitorare la variazione della copertura vegetale a seguito di un evento di natura franosa.
``` r
# Calcolo dell'NDVI (Normalized Difference Vegetation Index)
ndvi2017=(cengalo2017[[4]] - cengalo2017[[1]]) / (cengalo2017[[4]] + cengalo2017[[1]])     # NDVI = (NIR - red) / (NIR + red)
ndvi2018=(cengalo2018[[4]] - cengalo2018[[1]]) / (cengalo2018[[4]] + cengalo2018[[1]])     # NDVI = (NIR - red) / (NIR + red)

# Multiframe con gli NDVI  
im.multiframe(1,2)
plot(ndvi2017) 
plot(ndvi2018)
dev.off()
```
![ndvi](https://github.com/user-attachments/assets/ec430e25-d205-4231-9786-71cbcb347264)

***Figura 11.** NDVI dell'area in esame.*

I risultati ottenuti sono stati rappresentati in forma di **scatterplot (grafico a dispersione)** con la funzione `pairs` e il seguente `plot` rispetto ad una linea 1:1 per valutare la variazione della copertura vegetale.
Il rapporto tra NDVI del 2017 e NDVI del 2018 evidenzia: 
- un aumento della vegetazione: se i punti sono posti al di sopra della linea
- l'assenza di variazioni: se i punti sono posti sulla linea
- una perdita della copertura vegetale: se i punti sono posti al di sotto della linea

``` r
# Concatenamento degli NDVI 
ndvi=c(ndvi2017, ndvi2018)

# Verifica del concatenamento  
plot(ndvi[[1]])     # NDVI 2017
plot(ndvi[[2]])     # NDVI 2018

# Scatterplot
pairs(ndvi)
plot(ndvi[[1]], ndvi[[2]], xlab="NDVI 2017", ylab="NDVI 2018", main="Scatterplot NDVI")
abline(0, 1, col="red")
```
<img width="800" height="600" alt="pairsNDVI" src="https://github.com/user-attachments/assets/9b11ea2f-b58b-4da1-a30c-258efff8d7f1" />

***Figura 12.** Risultati della funzione*`pairs`.

<img width="800" height="600" alt="scatterplotNDVI" src="https://github.com/user-attachments/assets/18263c31-17f5-447b-96e3-f32cc7fe1ef8" />

***Figura 13.** Scatterplot dell'NDVI del 2017 rispetto all'NDVI del 2018.*
Dato che i punti risultano essere collocati al di sotto della linea 1:1 viene confermato l'impatto del fenomeno franoso che ha determinato una **perdita di vegetazione**. 

### 4.2 Variabilità spaziale 





👌
