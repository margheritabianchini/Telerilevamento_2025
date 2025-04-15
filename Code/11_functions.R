# Code to build your own functions 

# x e y sono i due numeri che l'utente scriverà 
somma <- function(x,y) {
  z=x+y
  return(z)
  }

# Exercise: make a new function called differenza
differenza <- function(x,y) {
  z=x-y
  return(z)
  }

mf <- function(nrow,ncol) {
  par(mfrow=c(nrow, ncol))
  }

mf(1,2) 
plot(sent[[1]])
plot(sentpca[[1]])

positivo <- function(x) {
  if(x>0) {
  print("questo numero è positivo, non lo sai?")
  }
  else if(x<0) {
    print("Questo numero è negativo, studia capra!")
  }
  else {
    print("Lo zero è zero.")}
}




