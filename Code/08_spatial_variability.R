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


# What to do in case of huge images 
# RICAMPIONAMENTO - riduzione della risoluzione spaziale 

im.list()
sent = im.import("sentinel.png")
sent = flip(sent)
plot(sent)

# numero di pixel totali
ncell(sent) * nlyr(sent)
# 794 * 798
# 2534448

# ricampionamento
senta = aggregate(sent, fact=2)
# la risoluzione passa 2 * 2 perchè moltiplico per 2 ogni lato del quadrato che rappresenta il pixel 
# il pixel iniziale è 1/4 di quello in uscita 
ncell(senta) * nlyr(senta)
# dividendoli otteniamo 4 
# perchè lo abbiamo ridotto di 4 volte 

senta5 = aggregate(sent, fact=5)
ncell(senta5) * nlyr(senta5)

# nel momento in cui si ricampiona significa ridurre del quadrato

#CALCOLO DEVIAZIONE STANDARD 
nira = senta [[1]]
sd3a = focal(nira, w=c(3,3), fun=sd)

# Exercise: make a multiframe and plot in RGB the three images (or, 2, 5)
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(senta, r=1, g=2, b=3)
im.plotRGB(senta5, r=1, g=2, b=3)

# si vede che con fattore 5 si perde il dettaglio dell'immagine 
# non sempre la risoluzione max è meglio di quella più bassa 
# es. immagine ad alta risoluzione può creare più rumore

nira = senta [[1]]
sd3a = focal(nira, w=c(3,3), fun=sd)
plot(sd3a)

# Exercise: calculate the standard deviation for the factor 5 image 
nira5 = senta5 [[1]]
sd3a5 = focal(nira5, w=c(3,3), fun=sd)
plot(sd3a5)

sd5a5 = focal(nira5, w=c(5,5), fun=sd)
plot(sd5a5)

im.multiframe(1,2)
plot(sd5a5)
plot(sd3a)

im.multiframe(2,2)
plot(sd3)
plot(sd3a) # fattore ric 2
plot(sd3a5) # fattore ric 5
plot(sd5a5) # fattore ric 5 e finestra mobile 5*5

p1 = im.ggplot(sd3)
p2 = im.ggplot(sd3a)
p3 = im.ggplot(sd3a5)
p4 = im.ggplot(sd5a5)

p1 + p2 + p3 + p4 

im.multiframe(2,2)
plot(sd3, col=mako(100))
plot(sd3a, col=mako(100)) 
plot(sd3a5, col=mako(100)) 
plot(sd5a5, col=mako(100)) 

# VARIANZA 
var3 = focal(nir, w=c(3,3), fun=var)
# oppure var3 = sd3^2 
sd5 = focal(nir, w=c(5,5), fun="sd")
var5=sd5^2
plot(sd5)
plot(var5)




