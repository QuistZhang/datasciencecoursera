corr <- function(directory, threshold = 0) {
        
        output <- as.numeric()
        for(file in list.files(directory))
        {
                filename <- paste(directory, "\\", file, sep="")
                table <- read.csv(filename)
                
                nrow(table[complete.cases(table),])
                
                if(nobs > threshold)
                {
                        output <- c(output, cor(table["sulfate"], table["nitrate"], use = "complete.obs"))
                }
        }
        
        as.numeric(output)
}