#Load functions, config elements
source("config.R")
ignore <- lapply(list.files(file.path(getwd(),"Functions"), full.names = TRUE),
                 source)

main <- function(){
  
  #Has it run before?
  if(mysql_exists(db = SAVE_DB, table_name = SAVE_TABLE)){
    
    #If so, just run for today's file
    results <- OneRing(date = to_mw(Sys.Date()))
    
  } else {
    
    #Otherwise, run for all files.
    filelist <- list.files("/a/squid/archive/sampled/", full.names = TRUE, pattern = "gz$")
    results <- do.call("rbind",parlapply(X = filelist, FUN = OneRing))
    
  }
}