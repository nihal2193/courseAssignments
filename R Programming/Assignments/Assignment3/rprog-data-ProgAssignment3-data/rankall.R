rankall <- function(outcome, num = "best") {
        out <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
        outsplit <- split(out, out$State)
        
        outcomes <- c("heart attack", "heart failure", "pneumonia")
        if(sum(outcome == outcomes)<1)
        {
                stop("invalid outcome")
        }
        if(outcome == "heart attack")
                outcomeName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        else if(outcome == "heart failure")
                outcomeName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        else
                outcomeName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        len <- length(outsplit)
        df <- data.frame(x =character(len), y = numeric(len))
        df.names <- c("hospital","state")
        for(i in 1:len)
        {
#                 print( (i))
                outcomeData <- outsplit[[i]][outcomeName]
                outcomeData <- cbind(outcomeData[[outcomeName]],outsplit[[i]]$Hospital.Name)
                
                # outcomeData <- outcomeData[complete.cases(outcomeData)]
                output <- matrix(outcomeData,ncol=2)
                
                output[,1] <- as.numeric(output[,1])
                #        print(output)
                y <- complete.cases(output)
                toutput <- output[y,]
                toutput <- matrix(toutput,ncol=2)
                #        print(toutput)
                #        print(min(toutput[,1]))
                minIndex <- which(output[,1] %in% min(toutput[,1]))
                #         print(minIndex)
                
                if(num=="worst")
                {
                        print(c("worst ",num))
                        maxIndex <- which(output[,1] %in% max(toutput[,1]))
                        df$hospital[i] <- sort(output[maxIndex,2])[length(maxIndex)]
                        df$state[i] <- names(outsplit)[i]
                }
                
                else if(nrow(toutput) > num && num!="best")
                {
                        print(c("num in range ",num))
                        sortedoutput <- sort(as.numeric(toutput[,1]))
                        #                 print(sortedoutput)
                        rank <- which(output[,1] %in% sortedoutput[num])
                        #                 print(rank)
                        df$hospital[i] <- output[rank,2][1]
                        df$state[i] <- names(outsplit)[i]
                }
                
                else if(nrow(toutput) < num && num!="best")
                {       
                        print(c("num out of range ",num))
                        df$hospital[i] <- NA
                        df$state[i] <- names(outsplit)[i]
                }
                else if(num=="best")
                {
                        print(c("best ",num ))
                        df$hospital[i] <- sort(output[minIndex,2])[1]
                        df$state[i] <- names(outsplit)[i]
                }
        }
        df <- data.frame(df$hospital,df$state)
        df
        
}