# R code for calculating spatial variability 
# quanto varia il sistema

library(terra)
library(imageRy)
library(viridis)
library(patchwork)
install.packages("RStoolbox")
library(RStoolbox)

# 24 26 25 
# ci riferiamo al calcolo della deviazione standard sulla popolazione 
# VARIANZA = somma degli scarti quadratici diviso al numero dei campioni presi 
# DEVIAZIONE STANDARD = radice quadrata della varianza

media = (24+25+26) / 3

#CALCOLO DELLA DEVIAZIONE STANDARD
num = (24-media)^2 + (26-media)^2 + (25-media)^2
den = 3 
varianza = num/den 
stdev = sqrt(varianza)
# 0.8164966

sd(c(24,26,25))
# R automaticamente calcola la dev standard sul campione (n-1)
# con molti campioni non cambierebbe più di tanto
# 1 

sd(c(24,26,25,49))
# ha tirato la curva ad espandersi verso una parte 

mean(c(24,26,25))
mean(c(24,26,25,49))

# la mediana è il valore centrale. es. nel primo caso è 25

#---------------------------

im.list()
sent = im.import("sentinel.png")
sent=flip(sent)

# Exercise: plot the image in RGB with the NIR ontop of the red component
# in questo modo mettiamo il NIR sulla componente RED 
im.plotRGB(sent, r=1, g=2, b=3)

# Exercise: make three plot with NIR ontop of each component:r, g, b
# dove si mette 3 e 2 non cambia nulla
# è solo il vicino infrarosso che fa cambiare 
dev.off()
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)

# verde fluorescente sono le praterie in alta quota 
# il bianco è neve
# oppure possono essere delle nuvole 



#-----------------

nir = sent[[1]]

# Exercise: plot the NIR band with the inferno 

plot(nir, col=inferno(100))

sd3 = focal(nir, w=c(3,3), fun=sd)
plot(sd3)
# vediamo la deviazione standard su una matrice 3 x 3 
# si vedono le zone in ciu c'è stata una variazione dell'infrarosso vicino
# variazione in crepacci, vegetazione 

im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)

# calcoliamo la deviazione standard su una finestra 5x5 
# per variazioni di dettaglio userò una moving window ristretta

dev.off()
sd5 = focal(nir, w=c(5,5), fun=sd)
plot(sd5)


im.multiframe(1,2)
plot(sd3)
plot(sd5)



# Exercise: use ggplot to plot the standard deviation
# funzione pensata per plottare delle singole bande 
im.ggplot(sd3)

# Exercise: plot the two sd maps (3 or 5) one beside the other with ggplot 
p1 = im.ggplot(sd3)
p2 = im.ggplot(sd5)

p1 + p2


# Plot the original nir and the standard deviations 
p3=im.ggplot(nir)
p3+p1











