complete <- function(directory, id = 1:332) {
        
        outputtable <- data.frame(id = integer(0), nobs = integer(0))
        
        for(i in id)
        {
                if(i<10)
                {
                        filename <- paste("00", i, sep="")
                }
                else if(i<100)
                {
                        filename <- paste("0", i, sep="")
                }
                else
                {
                        filename <- i
                }
                
                filename <- paste(directory, "\\", filename, ".csv", sep="")
                table <- read.csv(filename)
                
                nobs <- nrow(table[complete.cases(table),])
                
                #R losing column names when adding rows to an empty data frame
                #http://stackoverflow.com/questions/5231540/r-losing-column-names-when-adding-rows-to-an-empty-data-frame
                outputtable[nrow(outputtable)+1,] <- c(i, nobs)
        }
        
        print(outputtable)
}