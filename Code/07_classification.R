#R CODE FOR CLASSIFYNG IMAGES 


#Packages 
#install.packages("patchwork")
library(patchwork)
library(terra)
library(imageRy)
library(ggplot2)


#Content of the package 
im.list()


#MATO GROSSO 1992 -------------------------------------------------------------------------------------------------------------------------------------------------
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)


#MATO GROSSO 2006 --------------------------------------------------------------------------------------------------------------------------------------------------
mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)


#🎨Classify ---------------------------------------------------------------------------------------------------------------------------------------------------------
#clustering -> distinguishes based on a spectral/statistical similarity calculated by the algorithm.
mato1992c = im.classify(mato1992, num_clusters=2)     #[classify=generates a random classification based on the n classes (clusters indicate)]
                                                      #[num_clusters=number of classes]
# class 1 = forest
# class 2 = human


mato2006c = im.classify(mato2006, num_clusters=2)
# class 1 = human
# class 2 = forest


#[set.seed()=blocks the randomness of the classification. Idicates one of the possible classifications through a group of initial pixels]


#Calculation of frequency and total -------------------------------------------------------------------------------------------------------------------------------
#MATO GROSSO 1992
f1992 = freq(mato1992c)     #[freq=counts the frequency of pixel values]
tot1992 = ncell(mato1992c)     #[ncell=count the total number of pixels]


#Proportions
prop1992 = f1992 / tot1992     #frequency/total


#Proportions in percentage
perc1992 = prop1992 * 100     #(frequency/total)*100
# forest = 83%; human = 17%


#MATO GROSSO 2006 
tot2006 = ncell(mato2006c)
perc2006 = freq(mato2006c) * 100/ tot2006     #frequency*100/total
# human = 55%; forest = 45% 
#r tables are called dataframes


#Creating dataframe 
class = c("Forest", "Human")    #class definition 
y1992 = c(83,17)     #first column
y2006 = c(45, 55)     #second column 
tabout = data.frame(class, y1992, y2006)     #[data.frame=create a column-structured data table]


#📊 Histogram ----------------------------------------------------------------------------------------------------------------------------------------------------
#bar=istogrammi 
#stat=random statistics
p1 = ggplot(tabout, aes(x=class, y=y1992, color=class)) +      
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100))
#[ggplot=create a graph]
#[aes=specify the variables]
#[geom_bar=create a bar chart]
#[stat=indicates the statistical transformation of the data]
#[fill=filling the bars]
#[ylim= y-axis limit]


p2= ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100)) 
#[fill=class -> to have custom colors for the classes]
#ylim(c(0,100)) -> to display the data correctly, we place them on the same scale


#Patchwork package ------------------------------------------------------------------------------------------------------------------------------------------------
#merge ggplot graphs
p1 + p2     #the graphs are side by side
p1 / p2     #the graphs are one above the other


p0 = im.ggplot(mato1992)    #[im.ggplot=converts the raster into a data frame]
p00 = im.ggplot(mato2006)


p0 + p00 + p1 +p2

#☀️ SOLAR ORBITER -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#the data repository is on imageRy
#Solar gas data are represented


#Content of the package 
im.list()


solar = im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")    #identification of three energy levels


#EXERCISE: classify the image in three classes
solarc=im.classify(solar, num_clusters=3)
#classification into three energy levels


#EXERCISE: plot the original image beside the classified one
#🖼️ Multiframe 
dev.off()
im.multiframe(1,2)
plot(solar)
plot(solarc)


#Classes 
# 1 = low
# 2 = medium 
# 3 = high 


# 3 = medium
# 2 = high


#Substitution: funzione che serve a sostituire dei valori delle celle (associazione)
dev.off()
solarcs = subst(solarc, c(3,2,1), c("c1_low","c2_medium","c3_high"))     #[subst=replaces cell values (combination)]
                                                                         #there must be no spaces in the vector c
plot(solarcs)


#EXERCISE: calculate the percentages of the Sun energy classes with one line
percsolar = freq(solarcs)$count * 100 / ncell(solarcs)
# $ = only


# percsolar -> [1] 37.33349 41.44658 21.21993
# approximate percsolar -> [1] 38 41 21 


#Create dataframe 
class = c("c1_low","c2_medium","c3_high")
perc = c(21,38,41)
tabsol = data.frame(class, perc)


#Final ggplot
ggplot(tabsol, aes(x=class, y=perc, fill=class, color=class)) + 
  geom_bar(stat="identity") # + 
# ylim(c(0,100)) 
 coord_flip()     #swap the x-axis with y-axis
