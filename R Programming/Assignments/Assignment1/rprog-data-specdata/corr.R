corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  files <- list.files(directory)
  comp <- complete(directory,1:332)
  numFiles <- length(files)
  cvec <- numeric(0)
  for(i in 1:numFiles)
  {
      if(comp$nobs[i] > threshold)
      {
        f <- read.csv(paste(directory,"/",files[i], sep=""))
        n <- f$nitrate
        s <- f$sulfate
        cns <- complete.cases(n,s)
        
        cvec <- c(cvec,cor(f$nitrate[cns],f$sulfate[cns]))
      }
  }
  
  cvec
  ## Return a numeric vector of correlations
}