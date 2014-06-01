rankall <- function(outcome = "heart attack", num = "best")
{
        ##Read outcome data.
        table <- data.frame()
        table <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        table <- table[complete.cases(table), ]       #remove incomplete cases.
        
        ##Define output table.
        outputtable <- data.frame()
        
        
        ##Check whether the outcome is valid.
        if(!(outcome %in% c('heart attack','heart failure','pneumonia')))
                stop("invalid outcome")
        
        colIndex = NA
        if(outcome=='heart attack')
                colIndex = 11
        else if(outcome=='heart failure')
                colIndex = 17
        else if(outcome=='pneumonia')
                colIndex = 23
        
        #Get unique values of state column.
        states <- unique(table[, 7])
        states <- states[order(states)]
        
        for(state in states)
        {
                temptable<-table[table[, 7]==state,]
                suppressWarnings(temptable[,c(11, 17, 23)] <-sapply(temptable[,c(11, 17, 23)], as.numeric))
                hospital <- NA
                
                if(num == "best")
                {
                        min = min(temptable[, colIndex], na.rm = TRUE)
                        hospital <- as.character(head(sort(temptable[temptable[, colIndex] == min, 2]), n=1))
                }
                else if(num == "worst")
                {
                        max = max(temptable[, colIndex], na.rm = TRUE)
                        hospital <- as.character(head(sort(temptable[temptable[, colIndex] == max, 2]), n=1))
                }
                else
                {
                        temptable <- temptable[order(temptable[, colIndex], temptable[, 2]), ]     #order table.
                        if(num > nrow(temptable)) hospital <- NA
                        else hospital <- as.character(temptable[num, 2])
                }
               
                outputtable<- rbind(outputtable, cbind(hospital, state))
                
        }
        colnames(outputtable)<- c("hospital", "state")
        outputtable
}