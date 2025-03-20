# This code helps exporting graphs to images 

#Exporting data 
#selezionare la cartella di lavoro
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO")

getwd()

plot(gr)

#con png creiamo un file png 
png("greenland_output.png")
plot(gr) 
dev.off()
#con dev.off chiudiamo tutto 

#oltre al png si possono fare altri formati di file 
pdf("greenland_output.pdf")
plot(gr) 
dev.off()


pdf("difgreen.pdf")
plot(grdif)
dev.off()

#nel pdf non ho problemi di risoluzione dei numeri perchè è un vettoriale
jpeg("difgreen.jpeg")
plot(grdif)
dev.off()
