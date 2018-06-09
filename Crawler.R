# Reza Sadeghi
# 6/9/2018
# Simple Crawler
# sadeghi.2@wright.edu; reza@knoesis.org


# library(RCurl)
 library(XML)
 library(stringr)

#>>> Changing the user agent to avoid http error 999.
 #devtools::install_github("jeroenooms/curl")
 #library(curl)
 #h <- new_handle()
 #handle_setheaders(h, "User-Agent" = "Mozilla/5.0 (Windows NT 6.3; rv:36.0)
#Gecko/20100101 Firefox/36.0")
 
url<-'https://rezasadeghiwsu.github.io/Website/'
html <- paste(readLines(url), collapse="\n")
matched <- str_match_all(html, "<a href=\"(.*?)\"")
listPages <- matched[[1]][,2]
FatherListPages <- rep(url,length(listPages))
numberOfPages = 1000
i=0
j=0
while (TRUE){
  i=i+1
  url <- listPages[i]
  if(substr(url,1,4)!="http"){
    listPages [i]<- ""
    FatherListPages [i]<- ""
    next
  }
  possibleError <- tryCatch({
    html <- paste(readLines(url), collapse="\n")
    Flage<<-TRUE
  },error= function(e){
    print("Request denied")
    Flage<<-FALSE
  })
  if(inherits(possibleError, "error")) next
  if(!Flage)
  {
    next
  }
  matched <- str_match_all(html, "<a href=\"(.*?)\"")
  newListPages <- matched[[1]][,2]
  listPages <- c(listPages,newListPages)
  FatherListPages <- c(FatherListPages,rep(url,length(newListPages)))
  j=j+1
  if(j==numberOfPages){
    break
  }
}