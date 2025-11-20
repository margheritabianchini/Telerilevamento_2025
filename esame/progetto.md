## PROGETTO DI TELERILEVAMENTO GEO-ECOLOGICO IN R - A.A. 2024/2025
> #### Margherita Bianchini
------------------
# Caso di studio della frana di Pizzo Cengalo (Val Bondasca, Svizzera)

## Indice 
1. Introduzione
2. Dati
3. Metodo e risultati
   
   3.1 Visualizzazione delle immagini
   
   3.2 Calcolo dell'NDVI
   
   3.3 Variabilità spaziale
   
   3.4 Analisi multitemporale
   
   3.5 Classificazione
   
5. Discussione 
6. Conclusioni
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

***Figura 2.** Rappresentazione 3D della frana del 2017 riportata nel lavoro di Mergili et al. 2020*

Nel presente progetto sono stati inquadrati i due eventi principali che sono stati registrati nell'area e nel dettaglio è stato analizzato l'evento del 23 agosto 2017 confrontando lo scenario pre o post frana da un punto di vista di: 
- ***variabilità spaziale***
- ***indici spettrali***
- ***analisi multitemporale***
- ***impatto del fenomeno nell'area***
  
## 2. Dati 
Le immagini satellitari sono state scaricate da [Google Earth Engine](https://earthengine.google.com/). 


***Tabella 1.** Immagini satellitari utilizzate nell'analisi*

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

## 3. Metodo e risultati
### 3.1 Visualizzazione delle immagini 
Per prima cosa è stata impostata la working directory. 
``` r
# Set della working directory
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO/materiale progetto")
getwd()
```

Sono state richiamate, visualizzate ed esportate come file *.pgn* le immagini satellitari dei due relativi eventi:

***-> Evento 2011*** 
``` r
# Richiamo dei file
cengalo2011 = rast("landsat5_2011.tif")    # Landsat 5
cengalo2013 = rast("landsat8_2013.tif")    # Landsat 7

# Visualizzazione
plot(cengalo2011)                          # Landsat 5
plot(cengalo2013)                          # Landsat 7
```
![cengalo_2011](https://github.com/user-attachments/assets/ccbf7289-9fca-410f-a2a7-8b4d49480faa)
***Figura 3.** Area del Pizzo Cengalo nell'estate del 2011*

![cengalo_2013](https://github.com/user-attachments/assets/7c27fa40-d14a-45d3-8144-c79d61ec9cb8)
***Figura 4.** Area del Pizzo Cengalo nell'estate del 2013*

***-> Evento 2017*** 
``` r
# Richiamo dei file (evento 2017)
cengalo2017 = rast("sentinel2_estate2017.tif")    # Sentinel-2
cengalo2018 = rast("sentinel2_estate2018.tif")    # Sentinel-2

# Visualizzazione 
plot(cengalo2017)                                 # Sentinel-2
plot(cengalo2018)                                 # Sentinel-2 
```
![cengalo_2017](https://github.com/user-attachments/assets/d7e6920e-ba7a-47d2-b9fb-269235d6cfe3)
***Figura 5.** Area del Pizzo Cengalo nell'estate del 2017 (pre-evento)*

![cengalo_2018](https://github.com/user-attachments/assets/950c3939-c432-4fbc-a0d9-41baac9c3ecd)
***Figura 6.** Area del Pizzo Cengalo nell'estate del 2018*





