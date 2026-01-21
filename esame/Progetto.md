> #### Margherita Bianchini
> ## PROGETTO DI TELERILEVAMENTO GEO-ECOLOGICO IN R - A.A. 2024/2025
> #### Corso di Laurea Magistrale in Geologia e Territorio (LM-74)

# Caso di studio della frana di Pizzo Cengalo (Val Bondasca, Svizzera)

## Indice 
1. Introduzione
2. Dati
3. Visualizzazione degli eventi franosi principali 
4. Analisi dell'evento del 23.08.2017
   
   4.1 NDVI (Normalized Difference Vegetation Index) 
   
   4.2 Variabilità spaziale
   
   4.3 Analisi multitemporale
   
   4.4 Impatto del fenomeno 
5. Conclusioni
   
Bibliografia

## 1. Introduzione 
La mattina del 23 agosto 2017, nella località di Bregaglia (Val Bondasca, Svizzera), un volume di circa 3 x 10<sup>6</sup> m<sup>3</sup> si è distaccato dalla parete nord-est del Pizzo Cengalo (3368 m s.l.m.), innescando un **fenomeno franoso** che in pochi minuti ha raggiunto l'abitato di Bondo a valle.

<img width="800" height="600" alt="area_studio" src="https://github.com/user-attachments/assets/afe76574-4e7c-4024-9a8d-d15c9b11e99c" />


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
- ***indice spettrale (NDVI)***
- ***variabilità spaziale***
- ***analisi multitemporale***
- ***impatto del fenomeno*** 

In questo modo l'evento è stato valutato in funzione dell'*area coinvolta*, del *volume mobilizzato* e dei *cambiamenti morfologici*, al fine di fornire delle informazioni fondamentali nel **monitoraggio** delle zone suscettibili e nella la **gestione di futuri eventi franosi** di questa tipologia. 

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
cengalo2011 = rast("landsat5_2011.tif")    # Landsat 5 pre-evento
cengalo2013 = rast("landsat8_2013.tif")    # Landsat 8 post-evento

# Visualizzazione
plot(cengalo2011)                          # Landsat 5 pre-evento
plot(cengalo2013)                          # Landsat 8 post-evento 
```
![cengalo_2011](https://github.com/user-attachments/assets/c4cb1b61-e371-4bd9-80bf-e7c87fe9523c)


***Figura 3.** Area del Pizzo Cengalo nell'estate del 2011 (pre-evento).*

![cengalo_2013](https://github.com/user-attachments/assets/31345822-815d-4d8d-bf08-a09c124480a4)

***Figura 4.** Area del Pizzo Cengalo nell'estate del 2013 (post-evento).*

***-> Evento 2017*** 
``` r
# Richiamo dei file (evento 2017)
cengalo2017 = rast("sentinel2_estate2017.tif")    # Sentinel-2 pre-evento 
cengalo2018 = rast("sentinel2_estate2018.tif")    # Sentinel-2 post-evento 

# Visualizzazione 
plot(cengalo2017)                                 # Sentinel-2 pre-evento
plot(cengalo2018)                                 # Sentinel-2 post-evento 
```
![cengalo_2017](https://github.com/user-attachments/assets/5a174782-2c61-4264-b5c7-aac5a565332a)

***Figura 5.** Area del Pizzo Cengalo nell'estate del 2017 (pre-evento).*


![cengalo_2018](https://github.com/user-attachments/assets/290b1393-4e01-48d0-8fb2-f55b8494cda9)

***Figura 6.** Area del Pizzo Cengalo nell'estate del 2018 (post-evento).*

>[!NOTE]
> Ogni immagine presente in questo lavoro è stata esportata utilizzando la sequenza di funzioni di R:
> ``` r
> png("immagine.png")     # dettagli output 
> plot(immagine)          # plot immagine da esportare 
> dev.off()               # chiusura e salvataggio 
> ```

Le immagini sono state rappresentate nello **spettro visibile** con la funzione `im.plotRGB` che combina le tre bande in un'immagine RGB: 

***-> Evento 2011*** 
``` r
im.multiframe(1,2)                                                         # creazione di un multiframe 
im.plotRGB(cengalo2011, r=1, g=2, b=3, title="Pizzo Cengalo anno 2011")    # Landsat 5 pre-evento colori naturali 
im.plotRGB(cengalo2013, r=3, g=2, b=1, title="Pizzo Cengalo anno 2013")    # Landsat 8 post-evento colori narturali 
```
> [!TIP]
> L'immagine acquisita del satellite Landsat 8 è stata calibrata diversamente dalle altre dato che ha una diversa combinazione delle bande. 
>
> 
![evento2011_RGB](https://github.com/user-attachments/assets/69fe2465-e9ff-48db-b471-0bae86626786)

***Figura 7.** Rappresentazione dell'evento del 2011 nello spettro visibile.*

***-> Evento 2017*** 
``` r
im.plotRGB(cengalo2017, r=1, g=2, b=3, title="Pizzo Cengalo anno 2017")   # Sentinel-2 pre-evento colori naturali 
im.plotRGB(cengalo2018, r=1, g=2, b=3, title="Pizzo Cengalo anno 2018")   # Sentinel-2 post-evento colori naturali 
dev.off()                                                                 # chiusura del multiframe 
```
![evento2017_RGB](https://github.com/user-attachments/assets/aa821a02-b911-43d3-91fc-30f5d5a6df19)

***Figura 8.** Rappresentazione dell'evento del 2017 nello spettro visibile.*

Successivamente, sono state visualizzate in **falsi colori**, ponendo la banda dell'infrarosso vicino (NIR) sulla componente del rosso.
In questo si differenziano i vari elementi di un'immagine: 
- piante: riflettanza NIR molto alta 
- roccia: riflettanza NIR bassa 
- acqua: riflettanza NIR molto bassa

***-> Evento 2011*** 
``` r
im.plotRGB(cengalo2011, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2011")     # Landsat 5 pre-evento falsi colori 
im.plotRGB(cengalo2013, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2013")     # Landsat 8 post-evento falsi colori 
```
![evento2011_NIR](https://github.com/user-attachments/assets/25deed85-0705-4122-bf54-eb5ed35ffa65)

***Figura 9.** Visualizzazione dell'evento del 2011 in falsi colori.*

***-> Evento 2017*** 
``` r
im.plotRGB(cengalo2017, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2017")     # Sentinel-2 pre-evento falsi colori 
im.plotRGB(cengalo2018, r=4, g=3, b=2, title="Pizzo Cengalo NIR anno 2018")     # Sentinel-2 post-evento falsi colori 
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
# Calcolo NDVI
ndvi2017=(cengalo2017[[4]] - cengalo2017[[1]]) / (cengalo2017[[4]] + cengalo2017[[1]])     # NDVI = (NIR - red) / (NIR + red)
ndvi2018=(cengalo2018[[4]] - cengalo2018[[1]]) / (cengalo2018[[4]] + cengalo2018[[1]])     # NDVI = (NIR - red) / (NIR + red)

# Multiframe con gli NDVI  
im.multiframe(1,2)           # creazione di un multiframe
plot(ndvi2017)               # NDVI pre-evento
plot(ndvi2018)               # NDVI post-evento 
dev.off()                    # chiusura del multiframe 
```
![ndvi](https://github.com/user-attachments/assets/ec430e25-d205-4231-9786-71cbcb347264)

***Figura 11.** NDVI dell'area in esame.*

> [!NOTE]
> L'immagine della *Figura 11* è stata plottata con la scala cromatica **inferno**: 
> ``` r
> plot(ndvi2017, col=inferno(100), main="Pizzo Cengalo NDVI anno 2017")     # NDVI pre-evento
> plot(ndvi2018, col=inferno(100), main="Pizzo Cengalo NDVI anno 2018")     # NDVI post-evento 
> ```


I risultati ottenuti sono stati rappresentati in forma di **scatterplot (grafico a dispersione)** con la funzione `pairs` e il seguente `plot` rispetto ad una linea 1:1 per valutare la variazione della copertura vegetale.
Il rapporto tra NDVI del 2017 e NDVI del 2018 evidenzia: 
- un *aumento della copertura vegetale*: se i punti sono posti al di sopra della linea
- l'*assenza di variazioni*: se i punti sono posti sulla linea
- una *perdita della copertura vegetale*: se i punti sono posti al di sotto della linea

``` r
# Concatenamento degli NDVI 
ndvi=c(ndvi2017, ndvi2018)

# Verifica del concatenamento  
plot(ndvi[[1]])     # NDVI pre-evento 
plot(ndvi[[2]])     # NDVI post-evento 

# Scatterplot
pairs(ndvi)                                                                                # creazione matrice scatterplot 
plot(ndvi[[1]], ndvi[[2]], xlab="NDVI 2017", ylab="NDVI 2018", main="Scatterplot NDVI")    # scatterplot NDVI pre e post-evento 
abline(0, 1, col="red")                                                                    # inserimento linea 1:1 
```
<img width="800" height="600" alt="pairsNDVI" src="https://github.com/user-attachments/assets/9b11ea2f-b58b-4da1-a30c-258efff8d7f1" />

***Figura 12.** Risultati della funzione*`pairs`.

<img width="800" height="600" alt="scatterplotNDVI" src="https://github.com/user-attachments/assets/18263c31-17f5-447b-96e3-f32cc7fe1ef8" />

***Figura 13.** Scatterplot dell'NDVI del 2017 rispetto all'NDVI del 2018.*

Dato che i punti risultano al di sotto della linea 1:1 viene confermato l'impatto del fenomeno franoso che ha determinato una **perdita di della copertura vegetale**. 

-------
### 4.2 Variabilità spaziale 
Considerato il contesto topografico dell'area, la valutazione della variabilità spaziale è stata eseguita con l'NDVI. 
È stata calcolata la **deviazione standard** pre e post-frana con una matrice 3x3, utilizzando le funzioni `focal` e `sd`. 

``` r
# Calcolo della deviazione standard 
sd3_ndvi2017 = focal(ndvi2017, w=c(3,3), fun=sd)     # deviazione standard calcolata su una matrice 3x3
sd3_ndvi2018 = focal(ndvi2018, w=c(3,3), fun=sd)     # deviazione standard calcolata su una matrice 3x3 

# Plot dei risultati 
plot(sd3_ndvi2017)                                   # deviazione standard calcolata su una matrice 3x3 
plot(sd3_ndvi2018)                                   # deviazione standard calcolata su una matrice 3x3 
```
![sd_ndvi](https://github.com/user-attachments/assets/5ce1aabb-f9aa-4baf-a9cb-d460e3627d00)

***Figura 14.** Deviazione standard calcolata dell'NDVI (matrice 3x3).*


> [!NOTE]
> Le immagini di *Figura 15* sono state plottate con la scala cromatica **magma**. 
> ``` r
> plot(sd3_ndvi2017, col=magma(100), main="Deviazione standard NDVI 2017")    # deviazione standard calcolata su una matrice 3x3 con palette magma
> plot(sd3_ndvi2018, col=magma(100), main="Deviazione standard NDVI 2018")    # deviazione standard calcolata su una matrice 3x3 con palette magma 
> ```



I risultati mostrano la **variabilità spaziale locale** dei due scenari. 
I valori più alti si individuano in corrispondenza delle zone di impluvio interessate dal detrito mobilizzato, permettendo una definizione acccurata del perimetro della frana.
La *differenza di valori* tra l'anno 2017 e 2018 è legata all'impatto della frana che tende a ridurre la variabilità della copertura vegetale nell'area.

--------------
### 4.3 Analisi multitemporale
L'analisi è stata effettuata determinando la differenza tra i due diversi NDVI.
``` r
# Calcolo della differenza tra NDVI 
diff_ndvi = ndvi[[2]] -  ndvi[[1]]     # NDVI 2018 - NDVI 2017
plot(diff_ndvi)
```

<img width="800" height="600" alt="differenza_NDVI" src="https://github.com/user-attachments/assets/405e160e-89e9-4d18-be13-de25abe2beb7" />

***Figura 15.** Risultato della differenza tra l'NDVI dell'anno 2017 e 2018.*

> [!NOTE]
> L'immagine della *Figura 15* è stata plottata con la scala cromatica **inferno**: 
> ``` r
> plot(diff_ndvi, col=inferno(100), main="Differenza NDVI (anno 2018 - anno 2017)")       # NDVI 2018 - NDVI 2017
> ```


In *Figura 15* si possono osservare le aree in cui c'è stata una perdita di vegetazione. Queste, corrispondono alle zone di impluvio interessate dalla frana, oggetto dell'erosione e della deposizione di detrito. 

> [!TIP]
> A questa informazione si può associare un DoD dell'area per mappare con precisione le zone di erosione e deposizione. 

-----------
### 4.4 Impatto del fenomeno 
La stima dell'impatto del fenomeno franoso è stata svolta sulla differenza tra gli NDVI. 
In modo da ottenere dei risultati più precisi è stata rimossa la porzione di raster coperta dalle nuvole con la funzione `crop`. 
``` r
# Codice utilizzato per tagliare manualmente l'immagine
plot(diff_ndvi)
extent_interactive = drawExtent()                                                     # crea e definisce manualmente il rettangolo da ritagliare dell'immagine 
ndvi_diff_crop = crop(diff_ndvi, extent_interactive)                                  # ritaglia lo SpatRaster secondo l'extent selezionato 
plot(ndvi_diff_crop, main="Differenza NDVI ritagliato (anno 2018 - anno 2017)")       # visualizzazione del risultato 
writeRaster(ndvi_diff_crop, "ndvi_diff_crop.tif", overwrite=TRUE)                     # salvataggio del file ritagliato
```

Dopodichè, il raster ritagliato è stato classificato secondo due classi come riportato in *Figura 16*: 
- ***classe 1***: area invariata 
- ***classe 2***: detrito mobilizzato 

``` r
# Classificazione dell'immagine
cengaloc = im.classify(ndvi_diff_crop, num_clusters=2)     # classificazione NDVI 2018 - NDVI 2017
```

![classificazione](https://github.com/user-attachments/assets/6d3c2883-321c-46b3-a517-cc083a7cef3c)


***Figura 16.** Classificazione della differenza tra l'NDVI dell'anno 2017 e 2018.*

Per ciascuna classe è stata considerata la frequenza e il numero di celle, poi è stata calcolata la percentuale. 

``` r
# Calcolo della frequenza e del numero totale di celle
freq_cengalo = freq(cengaloc)                           # frequenza dei valori dei pixel che compongono il raster classificato 
freq_cengalo                                            # verifica dei valori calcolati 
tot_cengalo = ncell(cengaloc)                           # numero totale di pixel 

# Calcolo della proporzione e della percentuale 
prop_cengalo = freq_cengalo$count / tot_cengalo         # proporzione = (frequenza / totale)
perc_cengalo = prop_cengalo * 100                       # percentuale = (frequenza / totale) * 100
perc_cengalo                                            # verifica dei valori calcolati
```
I valori sono stati rappresentati in forma tabella e in forma grafica utilizzando il pacchetto `ggplot2`. 

``` r
# Rappresentazione dei dati in tabella
classi = c("Area invariata", "Detrito mobilizzato")     # definizione delle classi 
percentuale = c(98,2)                                   # colonna di valori
tabdetrito = data.frame(classi, percentuale)            # definizione finale della tabella
```
``` r
# Rappresentazione dei dati come istogramma 
p1 = ggplot(tabdetrito, aes(x=classi, y=percentuale, color=classi, fill=classi)) +  
  geom_bar(stat="identity") + 
   labs(title = "Impatto dell'evento 23.08.2017") +
  theme(
    plot.title = element_text(
      face = "bold",
      hjust = 0.5)) +
  ylim(c(0,100))
```

***Tabella 2.** Rappresentazione delle classi in forma di percentuale.*

|ID|CLASSI|PERCENTUALE (%)|                 
|--------|--------|---------|
|1|Area invariata|98|
|2|Detrito mobilizzato|2|


<img width="600" height="600" alt="p1_tabdetrito" src="https://github.com/user-attachments/assets/d7733dca-7ac7-4608-85c1-b0ac26d1beb8" />

***Figura 17.** Istogramma delle percentuali di ciascuna classe.*

----------
## 5. Conclusioni
L'analisi delle immagini satellitari pre e post-evento ha mostrato:
- i cambiamenti morfologici nell'area studiata 
- la perdita della copertura vegetale e la relativa estensione areale
- il perimetro della frana
- la stima del volume di detrito mobilizzato nell'evento
  
I dati raccolti possono essere utilizzati per: 
- **mappare** il corpo di frana e individuare le zone di deposizione o erosione 
- effettuare un **confronto con gli eventi precedenti** (anno 2011)
- supportare il **monitoraggio di futuri eventi franosi** nell'area
- contribuire all'approfondimento delle conoscenze di tali fenomeni e alla gestione del rischio anche in altre aree potenzilamente esposte (es. frana di Blatten)

<img width="600" height="600" alt="p1_tabdetrito" src="https://github.com/user-attachments/assets/0c22ac31-569a-44e3-b903-45a8d971cb90" />

***Figura 18.** Abitato di Bondo la mattina del 23.08.2017.*

---------
## Bibliografia 
Amann, F., Kos, A., Phillips, M., & Kenner, R. (2018). The Piz Cengalo Bergsturz and subsequent debris flows. In EGU General Assembly Conference Abstracts (p. 14700).

Haeberli, W. (2013). Mountain permafrost—research frontiers and a special long-term challenge. Cold Regions Science and Technology, 96, 71-76.

Mergili, M., Jaboyedoff, M., Pullarello, J., & Pudasaini, S. P. (2020). Back calculation of the 2017 Piz Cengalo–Bondo landslide cascade with r. avaflow: what we can do and what we can learn. Natural Hazards and Earth System Sciences, 20(2), 505-520.
