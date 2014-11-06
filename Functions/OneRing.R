OneRing <- function(date){
  
  #Grab sampled data and sieve it
  data <- log_sieve(sampled_logs(date))
  
  #Handle timestamps
  data$timestamp <- timestamp_handler(data$timestamp)
  
  #Geolocate
  data <- geo_handler(data)
  
  #Generate useful referers
  data$referer <- host_handler(data$referer)
  
  #Categorise and tag requests
  data <- tag_handler(data)
  
  #Aggregate
  data <- data[,j = list(pageviews = (.N*1000)), by = names(data)]
  
  #Print
  cat(".")
  
  #Return
  return(data)
}