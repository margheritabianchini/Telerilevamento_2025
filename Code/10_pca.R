#R CODE FOR PRINCIPAL COMPONENT ANALYSIS (PCA)
#The principal component will be identified instead of choosing a band
#the outputs do not change


#Packages 
library(imageRy)
library(terra)


#Content of the package 
im.list()


#🛰️ SENTINEL-2 (spatial resolution = 10m)
sent = im.import("sentinel.png")
sent = flip(sent)
plot(sent)


#we use a subset
#the fourth band is removed because it is not needed


sent = c(sent[[1]],sent[[2]],sent[[3]])
# NIR = band 1
# red = band 2
# green = band 3 


sentpca = im.pca(sent, n_samples=100000)    #[im.pca=calculates the principal components of pixel values]
                                            #[n_samples=randomly samples a subset of pixels]
                                            #graphically, the first image has much more information
                                            #using the third band would not make sense
                                            #so we use the first vertical component


tot = 77 + 54 + 6 
#137


77*100 / tot
#56.20438


#Standard deviation
sdpc1=focal(sentpca[[1]], w=c(3,3), fun="sd")
plot(sdpc1)


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#This is a multivariate analysis:
#1. Take the component with the highest variability
#2. Use it to calculate the standard deviation
#So compared to last time the choice was objective
#Since there is a correlation, using PCA is good practice
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#When using variables, they must always be analyzed in the same range
#Ex. temperature, elevation...the elevation will definitely be higher
#So we need to standardize them ex. dividing by the maximum 
