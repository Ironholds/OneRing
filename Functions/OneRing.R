OneRing <- function(date){
  
  #Grab sampled data and sieve it
  data <- log_sieve(sampled_logs(date))
  
  #Handle timestamps
  data$timestamp <- timestamp_handler(data$timestamp)
  
  #Geolocate
  data <- geo_handler(data)
  
  #Generate useful referers
  data$referer <- referer_handler(data$referer)
  
}