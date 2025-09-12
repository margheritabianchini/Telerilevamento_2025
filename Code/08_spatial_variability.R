#R CODE FOR CALCULATING SPATIAL VARIABILITY
#how much the system varies


#Packages 
library(terra)
library(imageRy)
library(viridis)
library(patchwork)
install.packages("RStoolbox")
library(RStoolbox)


# -----------------------------------------------------------------------------------------------------------------------------------------------------------------
# -> MEAN = sum of the sample values ​​divided by their number
# -> MEDIAN = indicates the central value of the sorted samples
# -> VARIANCE = sum of the quadratic deviations divided by the number of samples taken 
# -> STANDARD DEVIATION of the population = square root of variance
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------


#EXAMPLE
#24 26 25 

#Avarage
media = (24+25+26) / 3
#25

#Variance and standard deviation 
num = (24-media)^2 + (26-media)^2 + (25-media)^2     #sum of the quadratic deviations
den = 3     #number of samples taken
variance = num/den    #variance
#0.6666667
stdev = sqrt(variance)     #standard deviation 
#0.8164966


#Standard deviation variation (automatic)
#Three samples 
sd(c(24,26,25))    #[sd=automatic standard deviation on the sample (n-1)]
                   #with many samples it wouldn't change much
#1

#Four samples
sd(c(24,26,25,49))     #extending the curve towards one side
#12.02775


#Mean variation (automatic) 
#Three samples 
mean(c(24,26,25))
#25

#Four samples 
mean(c(24,26,25,49))
#31


#------------------------------------------------------------------------------------------------------------------------------------------------------------------


#Content of the package 
im.list()


#🛰️SENTINEL-2 BANDS (spatial resolution = 10m)
sent = im.import("sentinel.png")
sent=flip(sent)


#Layer (band)
#1=NIR 


#EXERCISE: plot the image in RGB with the NIR ontop of the red component
im.plotRGB(sent, r=1, g=2, b=3)


#EXERCISE: make three plot with NIR ontop of each component:r, g, b
#it doesn't change where you put 2 or 3
#it only depends on the NIR
#🖼️ Multiframe 
dev.off()
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)
#fluorescent green are the high altitude prairies
#white is snow or clouds 


#------------------------------------------------------------------------------------------------------------------------------------------------------------------


nir = sent[[1]]


#EXERCISE: plot the NIR band with the inferno 
plot(nir, col=inferno(100))


#Standard deviation on a 3x3 matrix 
sd3 = focal(nir, w=c(3,3), fun=sd)     #[focal=work pixel by pixel]
                                       #[w=window size]
                                       #[fun=function to apply]
plot(sd3)
#areas where there has been a change in the NIR
#variation in crevasses, vegetation


#🖼️ Multiframe 
im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)


#Standard deviation on a 5X5 matrix 
#For detail variations I will use a smaller moving window
dev.off()
sd5 = focal(nir, w=c(5,5), fun=sd)
plot(sd5)


#🖼️ Multiframe 
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




