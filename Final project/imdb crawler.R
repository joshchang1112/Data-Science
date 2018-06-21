

title <- list()
for(year in c(2013:2017)){
  url <- paste("https://www.imdb.com/search/title?year=",year,",",year,"&sort=boxoffice_gross_us,esc&page=1&ref_=adv_nxt",sep="")
  print(url)
  html <- htmlParse(GET(url),encoding = "UTF-8")
  title.list <- xpathSApply(html, "//span[@class='rating-rating ']/span[@class = 'value']", xmlValue)
  title2.list <- xpathSApply(html, "//p[@class='rating-rating ']/span[@class = 'value']", xmlValue)
  title <- rbind(title, as.matrix(title.list))
  
  url <- paste("https://www.imdb.com/search/title?year=",year,",",year,"&sort=boxoffice_gross_us,esc&page=2&ref_=adv_nxt",sep="")
  print(url)
  html <- htmlParse(GET(url),encoding = "UTF-8")
  title.list <- xpathSApply(html, "//span[@class='rating-rating ']/span[@class = 'value']", xmlValue)
  title <- rbind(title, as.matrix(title.list))
}
title <- unlist(title)
title <- as.numeric(title)
title[464] <- mean(title)
data$imdb_Rate <- as.numeric(title)
