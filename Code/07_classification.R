#R code for classifying images

#install.packages("patchwork")
library(patchwork)
library(terra)
library(imageRy)
library(ggplot2)


im.list()

mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)


mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)


#CLASSIFY: una delle possibili classificazioni che parte in modo random in funzione alle n classi = clusters indicate 

mato1992c = im.classify(mato1992, num_clusters=2)
# class 1 = forest 
# class 2 = human 


mato2006c = im.classify(mato2006, num_clusters=2)
# class 1 = human
# class 2 = forest

#un modo per bloccare la classificazione è tramite seed. Perchè indica una delle possibili classificazioni, tramite un gruppo di pixel iniziali

# CALCOLO DELLA FREQUENZA E TOTALE -> quante volte abbiamo un certo valore (pixel)
f1992 = freq(mato1992c)
tot1992 = ncell(mato1992c)
#PROPORZIONI
prop1992 = f1992 / tot1992 
#PROPORZIONI IN PERCENTUALE 
perc1992 = prop1992 * 100

# forest = 83%; human = 17%

tot2006 = ncell(mato2006c)
perc2006 = freq(mato2006c) * 100/ tot2006

# human = 54%; forest = 46% 
#in R le tabelle hanno il nome di dataframe 

#CREATING DATAFRAME
class = c("Forest", "Human")
y1992 = c(83,17)
y2006 = c(45, 55)
tabout = data.frame(class, y1992, y2006)


#bar = istogrammi stat=statistica causale
p1 = ggplot(tabout, aes(x=class, y=y1992, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))

#mettere fill=class per avere colori personalizzati in funzione alle classi 

p2= ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100)) 

#PATCHWORK= serve per unire grafici di ggplot 

p1 + p2
p1 / p2

#ylim(c(0,100))per mostrare correttamente i dati li posizioniamo sulla stessa scala 

p0 = im.ggplot(mato1992)
p00 = im.ggplot(mato2006)

p0 + p00 + p1 +p2  


#-----Solar orbiter
#prende dati per quanto riguarda il sole
#il deposito dati lo troviamo su imageRy 
#vengono rappresentati i gas del Sole 

im.list()
solar = im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#possiamo inidviduare 3 diversi livelli di energia individuabili 

#Exercise: classify the image in three classes - im.classify()
solarc=im.classify(solar, num_clusters=3)
#in questo modo abbiamo i 3 livelli energetici


#Exercise: plot the original image beside the classified one 
dev.off()
im.multiframe(1,2)
plot(solar)
plot(solarc)

# 1 = low
# 3 = medium
# 2 = high

#Subst: funzione che serve a sostituire dei valori delle celle (associazione)
dev.off()
solarcs = subst(solarc, c(1,3,2), c("c1_low","c2_medium","c3_high"))
#nel vettore c non metto spazi 
plot(solarcs)

#Exercise: calculate the percentages of the Sun energy classes with one line 
percsolar = freq(solarcs)$count * 100 / ncell(solarcs)
# $ = solo

# [1] 37.33349 41.44658 21.21993
# [1] 38 41 21 

# create dataframe
class = c("c1_low","c2_medium","c3_high")
perc = c(38,21,41)
tabsol = data.frame(class, perc)

#final ggplot

ggplot(tabsol, aes(x=class, y=perc, fill=class, color=class)) + 
  geom_bar(stat="identity") # + 
# ylim(c(0,100)) 
 coord_flip()















