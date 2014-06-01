rankhospital <- function(state, outcome, num = "best")
{
        ##Read outcome data.
        table <- data.frame()
        table <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        
        ##Check that state and outcome are valid
        if (!(state %in% table[, 7]))
                stop("invalid state")
        if(!(outcome %in% c('heart attack','heart failure','pneumonia')))
                stop("invalid outcome")
        
        ##Return hospital name in that state with lowest 30-day death
        # col 11 --- Hospital 30-Day Death Rates from Heart Attack
        # col 17 --- Hospital 30-Day Death Rates from Heart Failure
        # col 23 --- Hospital 30-Day Death Rates from Pneumonia
        table<-table[table[, 7]==state,]
        
        suppressWarnings(table[,c(11, 17, 23)] <-sapply(table[,c(11, 17, 23)], as.numeric))
        
        colIndex = NA
        if(outcome=='heart attack')
                colIndex = 11
        else if(outcome=='heart failure')
                colIndex = 17
        else if(outcome=='pneumonia')
                colIndex = 23
        
        if(num == "best")
        {
                min = min(table[, colIndex], na.rm = TRUE)
                as.character(head(sort(table[table[, colIndex] == min, 2]), n=1))
        }
        else if(num == "worst")
        {
                max = max(table[, colIndex], na.rm = TRUE)
                as.character(head(sort(table[table[, colIndex] == max, 2]), n=1))
        }
        else
        {
                table <- table[complete.cases(table), ]
                table <- table[order(table[, colIndex], table[, 2]), ]
                if(num > nrow(table)) NA
                else table[num, 2]
        }
        
}