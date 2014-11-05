referer_handler <- function(referers){

  #Iconv
  referers <- iconv(referers, to = "UTF-8")
  
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
  
  #Categorise
  referers[grepl(x = referers, pattern = "((commons|meta|species)\\.((m|zero)\\.)?wikimedia\\.)|(wik(tionary|isource|ibooks|ivoyage|iversity|iquote|inews|ipedia|idata)\\.)",
                 useBytes = TRUE, perl = TRUE)] <- "Internal"
  referers[grepl(x = referers, pattern = "google(usercontent)?.", perl = TRUE, useBytes = TRUE)] <- "Google"
  referers[grepl(x = referers, pattern = "yahoo.", fixed = TRUE)] <- "Yahoo"
  referers[grepl(x = referers, pattern = "yandex.", fixed = TRUE)] <- "Yandex"
  referers[grepl(x = referers, pattern = "baidu.", fixed = TRUE)] <- "Baidu"
  referers[grepl(x = referers, pattern = "reddit.com", fixed = TRUE)] <- "Reddit"
  referers[grepl(x = referers, pattern = "ask.com", fixed = TRUE)] <- "Ask"
  referers[grepl(x = referers, pattern = "facebook.", fixed = TRUE)] <- "Facebook"
  referers[grepl(x = referers, pattern = "aol.", fixed = TRUE)] <- "AOL"
  referers[grepl(x = referers, pattern = "naver.", fixed = TRUE)] <- "Naver"
  referers[grepl(x = referers, pattern = "duckduckgo.", fixed = TRUE)] <- "DuckDuckGo"
  referers[grepl(x = referers, pattern = "sogou.", fixed = TRUE)] <- "Sogou"
  referers[grepl(x = referers, pattern = "bing.", fixed = TRUE)] <- "Bing"
  referers[grepl(x = referers, pattern = "daum.", fixed = TRUE)] <- "Daum"
  referers[grepl(x = referers, pattern = "t.co", fixed = TRUE)] <- "Twitter"
  referers[grepl(x = referers, pattern = "seznam.cz", fixed = TRUE)] <- "Seznam"
  referers[grepl(x = referers, pattern = "startpage.", fixed = TRUE)] <- "Startpage"
  referers[!referers %in% c("Internal","Google","Yahoo","Yandex","Baidu","Reddit","None",
                            "Ask", "Facebook", "AOL", "Naver","DuckDuckGo","Sogou",
                            "Bing","Daum","Twitter","Seznam","Startpage")] <- "Other"
  
  #Return
  return(referers)
}