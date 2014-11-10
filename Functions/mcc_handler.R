mcc_handler <- function(x_analytics){
  
  #Split and apply
  results <- unlist(lapply(X = strsplit(x = x_analytics, split = ";", fixed = TRUE), function(x){
    
    if(length(x) == 1){
      return("NA")
    }
    
    for(i in seq_along(x)){
      
      if(grepl(x = x[i], pattern = "zero", fixed = TRUE)){
        return(gsub(x = x[i], pattern = "zero=", fixed = TRUE, replacement = ""))
      }
    }
    
    return("NA")
  }))
  
  #Return
  return(results)
}