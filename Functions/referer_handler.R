referer_handler <- function(referers){

  #Extract domain
  referers <- unlist(lapply(referers,function(x){
    
    #Grab hostname
    try_results <- try({expr = 
    hostname <- parse_url(x)$hostname
    }, silent = TRUE)
    
    #Check - did it work?
    if("try-error" %in% class(try_results)){
      return("None")
    }
    
    #If so, did it find anything?
    if(is.null(hostname)){
      return("None")
    }
    
    #If not, return
    return(hostname)
  }))
}