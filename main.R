#Load functions, config elements
source("config.R")
ignore <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE),
                 source)

main <- function(){
  
  #Otherwise, run for all files.
  filelist <- list.files("/a/squid/archive/sampled", full.names = TRUE, pattern = "gz$")
  results <- do.call("rbind",parlapply(X = filelist, FUN = OneRing))
  
  #Aggregate
  results <- results[,j = list(pageviews = sum(pageviews)), by = names(results)[!names(results) == "pageviews"]]
  
  #Write
  mysql_write(results, SAVE_DB, SAVE_TABLE)
}

#Run, quit
main()
q()