best <- function(state, outcome)
{
        #debug = TRUE
        
        ##Read outcome data.
        table <- data.frame()
        #table <- read.csv("outcome-of-care-measures1.csv", colClasses="character")
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
        
        #if(debug){
        #        print(head(table[order(table[, 17]), c(2, 7, 11, 17, 23)], n=5))
        #        print(min(table[, 17], na.rm = TRUE))
        #}
	
        colIndex = NA
	min = NA
        if(outcome=='heart attack')
                colIndex = 11
        else if(outcome=='heart failure')
                colIndex = 17
        else if(outcome=='pneumonia')
                colIndex = 23
	
        #Calculate the min value of death rate for a specific outcome.
        min = min(table[, colIndex], na.rm = TRUE)
        
        #Only keep the hopital which have the least death rate and then sort them by name.
	as.character(head(sort(table[table[, colIndex] == min, 2]), n=1))
}
