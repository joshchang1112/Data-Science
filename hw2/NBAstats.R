rm(list = ls())
library(rvest) #開啟rvest套件

#球隊名稱
nbateam <- c("bucks","magic", "hawks", "clippers", "knicks", "pelicans", "raptors")

#爬蟲的網站
title1 <- read_html("http://www.nba.com/bucks/stats?sort=PTS")
buckstitle <- c(".playerName", ".playerNumber", ".gp", ".pts", ".reb", ".ast", ".fg_pct")
name <- c("Player", "Number", "Games", "Pts", "Reb", "Ast","Fg%")

i <- 1 

for(i in c(1:length(buckstitle))){
  title <- html_nodes(title1,buckstitle[i])
  title <- html_text(title)
  title <- iconv(title,"UTF-8")
  if(i > 2){
    newtitle <- title[2:(length(title)/2)]
    if(i == 3){
      game <- as.numeric(newtitle)
    }
  }else{
    newtitle <- title[1:(length(title)/2)]
  }
  if(i > 3 && i < 7){
    newtitle <- round(as.numeric(newtitle) / game , digits = 1)
  }
    
  if(i == 1){
    frame <- data.frame(newtitle)
  }else{
      frame <- data.frame(frame, newtitle)
  }
}

colnames(frame) <- name 

#Sort with pts
frame1 <- frame[order(frame$Pts , decreasing = TRUE),]

#Sort with reb
frame2 <- frame[order(frame$Reb , decreasing = TRUE),]

#Sort with Ast
frame3 <- frame[order(frame$Ast , decreasing = TRUE),]



