#CODE TO  BUILD YOUR OWN FUNCTIONS 


#x and y are the two numbers that the user will write
somma <- function(x,y) {
  z=x+y
  return(z)
  }


#EXERCISE: make a new function called differenza
differenza <- function(x,y) {
  z=x-y
  return(z)
  }


mf <- function(nrow,ncol) {     
  par(mfrow=c(nrow, ncol))    #[par=set the graphic parameters]
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
