timestamp_handler <- function(timestamps){
  
  #Convert
  timestamps <- as.POSIXlt(timestamps)
  
  #Strip
  minute(timestamps) <- 0
  second(timestamps) <- 0
  
  #Return
  return(as.character(timestamps))
}