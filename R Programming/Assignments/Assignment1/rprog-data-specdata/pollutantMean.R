pollutantmean <- function(directory, pollutant, id = 1:332)
{
  wd <- getwd()
  numFiles <- length(id)
  means <- vector("numeric", length = numFiles)
  
  for(i in 1:numFiles)
  {
    lid <- nchar(id[i])
    if(lid == 1)
      file <- paste(paste(directory, "/00",id[i],sep = ""), ".csv", sep = "")
    else if(lid == 2)
      file <- paste(paste(directory, "/0",id[i],sep = ""), ".csv", sep = "")
    else
      file <- paste(directory, "/", id[i], ".csv", sep = "")
    
    x <- read.csv(file)
    y <- x[pollutant]
    nay <- is.na(y)
    
    temp <- as.list(y[!nay])
    l1 <- c(l1 , temp)
  }
  mean(as.numeric(l1))

}