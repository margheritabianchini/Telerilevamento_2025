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
<img width="767" height="625" alt="vista_frana " src="https://github.com/user-attachments/assets/a72da3a1-8fe7-4073-9782-bf807e5b150a" />

![evento2017](<img width="767" height="625" alt="vista_frana " src="https://github.com/user-attachments/assets/a72da3a1-8fe7-4073-9782-bf807e5b150a" />)

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
All'inizio è stata impostata la cartella di lavoro e sono state importate le immagini satellitari dei due relativi eventi.
``` r
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
```







