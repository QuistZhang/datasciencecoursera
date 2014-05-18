pollutantmean <- function(directory, pollutant, id = 1:332) 
{
        table <- data.frame()
        
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
                table <- rbind(table, read.csv(filename, header=TRUE))
        }
        
        round(mean(table[[pollutant]], na.rm = TRUE), 3)
}