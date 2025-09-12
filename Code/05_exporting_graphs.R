#R CODE TO HELP EXPORT GRAPHS TO IMAGE


#Exporting data -----------------------------------------------------------------------------------------------------------------------------------------------------
setwd("C://Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO")     #[setwd=select the working directory]
#For Mac(Apple) setwd("/Users/margh/Desktop/GEOLOGIA E TERRITORIO (LM-74)/TELERILEVAMENTO")
getwd()     #[getwd=returns the current working directory]

plot(gr)


#🌄 png file 
png("greenland_output.png")     #[png=create a png file]
plot(gr) 
dev.off()


#📄pdf file 
pdf("greenland_output.pdf")     #[pdf=create a pdf file]
plot(gr) 
dev.off()


#📄pdf file 
pdf("difgreen.pdf")
plot(grdif)
dev.off()
#there is no image resolution problem because it is a vector file

#🌄 jpeg file 
jpeg("difgreen.jpeg")     #[jpeg=create a jpeg file]
plot(grdif)
dev.off()
