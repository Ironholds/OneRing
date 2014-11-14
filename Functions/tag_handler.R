tag_handler <- function(data){
  
  #Identify spiders
  uas <- ua_parse(data$user_agent)
  crawlers <- wiki_crawler(data$user_agent)
  
  is_spider <- logical(nrow(data))
  is_spider[uas$device == "Spider" | crawlers] <- TRUE
  
  is_automata <- logical(nrow(data))
  is_automata[uas$device == "Reuser"] <- TRUE
  
  #Device class
  device_class <- device_classifier(uas$device)
  
  #Iconv URLs
  urls <- iconv(data$URL, to = "UTF-8")
  
  #Identify site
  site <- character(nrow(data))
  site[grepl(x = urls, pattern = "api.php", fixed = TRUE)] <- "App"
  site[grepl(x = urls, pattern = "zero.", fixed = TRUE) & site == ""] <- "Mobile web"
  site[grepl(x = urls, pattern = "m.w", fixed = TRUE) & site == ""] <- "Mobile web"
  site[site == ""] <- "Desktop"
  
  #Is it a zero request?
  is_zero <- logical(nrow(data))
  is_zero[grepl(urls, pattern = "zero.", fixed = TRUE)] <- TRUE
  is_zero[grepl(data$x_analytics, pattern = "zero", fixed = TRUE)] <- TRUE
  
  #Site version
  mobile_site_version <- character(nrow(data))
  mobile_site_version[grepl(x = data$x_analytics, pattern = "mf-m=b", fixed = TRUE)] <- "Beta"
  mobile_site_version[grepl(x = data$x_analytics, pattern = "mf-m=a", fixed = TRUE)] <- "Alpha"
  mobile_site_version[site == "Mobile web" & mobile_site_version == ""] <- "Production"
  mobile_site_version[mobile_site_version == ""] <- "NA"
  
  #Identify project
  project <- project_handler(data$URL)
  
  #Identify Zero MCC
  mcc <- mcc_handler(data$x_analytics)
  
  #Bind
  results <- as.data.table(
    data.frame(timestamp = data$timestamp, country = data$country, refering_site = data$referer,
               project = project, device_class = device_class, access_method = site, is_zero = is_zero, is_spider = is_spider,
               is_automata = is_automata, mobile_site_version = mobile_site_version, mcc = mcc,
               stringsAsFactors = FALSE)
  )
  
  #Return
  return(results)
}