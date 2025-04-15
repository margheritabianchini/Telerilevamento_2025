# R code for Principal Component Analysis 

# cambia che invece di scegliere una banda verrà individuata la componente principale
# gli output non cambiano

library(imageRy)
library(terra)

im.list()

sent = im.import("sentinel.png")
sent = flip(sent)
plot(sent)

# togliamo la quarta banda perchè non ci serve 
# usiamo un subset 


sent = c(sent[[1]],sent[[2]],sent[[3]])
# NIR = band 1
# red = band 2
# green = band 3 



sentpca = im.pca(sent, n_samples=100000)


# a livello grafico la prima immagine ha molta più informazione 
# infatti usare la terza banda non avrebbe senso 
# quindi andiamo ad usare LA PRIMA COMPONENTE PRINCIPALE


tot = 77 + 54 + 6 
#137

77*100 / tot


sdpc1=focal(sentpca[[1]], w=c(3,3), fun="sd")
plot(sdpc1)

# questa volta abbiamo fatto un analisi multivariata
# preso la componente con variabilità più alta 
# e la abbiamo utilizzata per calcolare la standard deviation 
# quindi rispetto la scorsa volta la scelta è stata oggettiva 
# dato che c'è una correlazione. usare la pca è buona norma 


# quando si usano variabili
# BISOGNA SEMPRE ANALIZZARLE SULLO STESSO RANGE 
# Es. temperatura, elevation. sicuramente vincerà elevation
# quindi bisogna standardizzarle. es. DIVIDENDO PER IL MAX 







