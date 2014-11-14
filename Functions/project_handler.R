project_handler <- function(urls){
  
  #Iconv
  urls <- iconv(urls, to = "UTF-8")
  
  #Split and filter
  urls <- unlist(lapply(strsplit(x = urls, split = ".", fixed = TRUE), function(x){
    
    #For UTF-8 problems...
    if(length(x) == 1){
      return("Unknown")
    }
    
    #Mobile? Return the first and third entries
    if(x[2] %in% c("m","wap","zero","mobile")){
      return(paste(x[c(1,3)],collapse = "."))
    }
    
    #No language code?
    if(grepl(x = x[2], pattern = "org", fixed = TRUE)){
      return("Unknown")
    }
    
    #Otherwise, first and second
    return(paste(x[1:2], collapse="."))
    
  }))
  
  #Substitute
  urls <- gsub(x = urls, pattern = "http(s)?://", useBytes = TRUE, perl = TRUE, replacement = "")
  
  #Return
  return(urls)
}