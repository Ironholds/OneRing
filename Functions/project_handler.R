project_handler <- function(urls){
  
  #Limit to hostname
  urls <- host_handler(urls, strict = FALSE)
  
  #Split and filter
  urls <- unlist(lapply(strsplit(x = urls, split = ".", fixed = TRUE), function(x){
    
    #For UTF-8 problems...
    if(length(x) == 1){
      return("Unknown")
    }
    
    #Mobile? Return the first and third entries
    if(x[2] == "m"){
      return(paste(x[c(1,3)],collapse = "."))
    }
    
    #Otherwise, first and second
    return(paste(x[1:2], collapse="."))
    
  }))
  
  #Return
  return(urls)
}