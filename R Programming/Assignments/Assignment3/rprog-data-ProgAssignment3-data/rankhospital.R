rankhospital <- function(state, outcome, num="best")
{
        out <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
        outsplit <- split(out, out$State)
        
        ## Check that state and outcome are valid
        if(sum(state == names(outsplit))<1)
        {
                stop("invalid state")
        }
        
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
        ## Return hospital name in that state with lowest 30-day death
        stIndex <- which (names(outsplit) %in% state)
        #         print(c(" state ",stIndex))
        outcomeData <- outsplit[[stIndex]][outcomeName]
        outcomeData <- cbind(outcomeData[[outcomeName]],outsplit[[stIndex]]$Hospital.Name)
        
        # outcomeData <- outcomeData[complete.cases(outcomeData)]
        output <- matrix(outcomeData,ncol=2)
        
        output[,1] <- as.numeric(output[,1])
        #        print(output)
        y <- complete.cases(output)
        toutput <- output[y,]
        #        print(toutput)
        #        print(min(toutput[,1]))
        minIndex <- which(output[,1] %in% min(toutput[,1]))
        #         print(minIndex)
        if(num=="best")
                sort(output[minIndex,2])[1]
        else if(num=="worst")
        {
                maxIndex <- which(output[,1] %in% max(toutput[,1]))
                sort(output[maxIndex,2])[length(maxIndex)]
        }
        else if(nrow(toutput) < num)
                NA
        else
        {
                #                 print("else")
                sortedoutput <- sort(as.numeric(toutput[,1]))
                #                 print(sortedoutput)
                rank <- which(output[,1] %in% sortedoutput[num])
                #                 print(rank)
                output[rank,2][1]
        }
}