rm(list = ls())
library(XML)
library(rvest)

#爬取30支球隊的名稱
teams <- read_html("http://www.nba.com/teams")
teamstitle <- c(".team__list")
title <- html_nodes(teams,teamstitle)
title <- html_text(title)
title <- iconv(title,"UTF-8")
title <- tolower(title)

# title中的index 1~30 代表30支球隊
b <- strsplit(title[17],split=" ")
names(b) <- "Teamname"
b$Teamname[2]

#爬取球隊每位球員的數據
url <- paste("http://www.nba.com/" , b$Teamname[2] , "/stats", sep="")

dt1 <- readHTMLTable(url)
frame <- dt1[[2]]
#names(frame)

#將名字中的亂碼移除
playername <- as.character(frame$Player)
playername1 <- strsplit(playername , split = "\u0095", fixed=T)

frame$Player <- as.character(frame$Player)
for (i in 1:length(frame$Player)) {
  frame$Player[i] <- playername1[[i]][1]
}

frame <- data.frame(frame$Player,frame$G,frame$PTS,frame$`FG%`,frame$`3P%`,frame$REB,frame$AST,frame$STL)
names(frame) <- c("Player","G","PTS","FG%","3P%","REB","AST","STL") 

#Sort with pts
frame1 <- frame[order(as.numeric(as.character(frame$PTS)) , decreasing = TRUE),]

#Sort with reb
frame2 <- frame[order(as.numeric(as.character(frame$REB)) , decreasing = TRUE),]

#sort with ast
frame3 <- frame[order(as.numeric(as.character(frame$AST)) , decreasing = TRUE),]

#sort with stl
frame4 <- frame[order(as.numeric(as.character(frame$STL)) , decreasing = TRUE),]


abc <- as.character(frame$`3P%`)
num3pt <- as.numeric(strsplit(abc,split="%"))

#sort with 3pt%
frame5 <- frame[order((num3pt) , decreasing = TRUE),]



