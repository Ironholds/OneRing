geo_handler <- function(x){
  
  #Handle x_forward_fors
  is_xff <- !x$x_forwarded == "-"
  x$ip_address[is_xff] <- x$x_forwarded[is_xff]
  
  #Geolocate to country level
  x$country <- geo_country(x$ip_address)
  
  #Return
  return(x)
}