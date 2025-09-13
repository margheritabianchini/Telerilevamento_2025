#R CODES FOR INSTALLING PACKAGES FROM GITHUB
#The packages on the cran need to be reviewed
#Packages on github stay forever


# From GitHub:
library(devtools) #or remotes
install_github("ducciorocchini/cblindplot")
library(cblindplot)


# From GitHub:
# install.packages("dev.tools")
install_github("clauswilke/colorblindr")     #colorblindness 
library(colorblindr)


# From CRAN: 
install.packages("colorblindcheck")
library(colorblindcheck)
