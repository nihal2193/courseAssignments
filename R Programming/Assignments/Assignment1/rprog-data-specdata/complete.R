complete <- function(directory, id = 1:332) 
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  numFiles <- length(id)
  
  df <- data.frame(id = numeric(numFiles), nobs = numeric(numFiles))
  
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
    s <- x$sulfate
    n <- x$nitrate
    cns <- complete.cases(s,n)
    df$id[i] <- i
    df$nobs[i] <- sum(cns)
  }
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  df
}