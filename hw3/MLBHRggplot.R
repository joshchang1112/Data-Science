library(XML)
library(rvest)
install.packages("dplyr")
library(dplyr)
#爬取30支球隊全壘打的數量
homeruns <- read_html("https://www.baseball-reference.com/leagues/MLB/2017.shtml")
homerunstitle <- c("tbody td.left+ .right")
HR <- html_nodes(homeruns,homerunstitle)
HR <- html_text(HR)
HR <- iconv(HR,"UTF-8")
HR <- HR[1:30]
#HR



#爬取30支球隊的名稱
teams <- read_html("https://www.baseball-reference.com/teams/")
teamstitle <- c("#teams_active .left a")
Team <- html_nodes(teams,teamstitle)
Team <- html_text(Team)
Team <- iconv(Team,"UTF-8")
#Team

df1 = data.frame(Team, HR)

#爬取30支球隊的戰績
winloses <- read_html("http://www.espn.com/mlb/standings/_/sort/gamesbehind/dir/asc/season/2017/group/overall")
winlosestitle <- c(".Table2__td:nth-child(1) .stat-cell , .hide-mobile a")
Winlose <- html_nodes(winloses,winlosestitle)
Winlose <- html_text(Winlose)
Winlose <- iconv(Winlose,"UTF-8")
#Winlose

df2 <- data.frame(Winlose[1:30],Winlose[31:60])

winlosestitle <- c(".Table2__td:nth-child(2) .stat-cell")
Winlose <- html_nodes(winloses,winlosestitle)
Winlose <- html_text(Winlose)
Winlose <- iconv(Winlose,"UTF-8")
df2 <- data.frame(df2,Winlose[1:30])
names(df2) <- c("Team", "Wins", "Loses")

#將兩個表格合併
df <- merge(df1, df2, by = "Team")

areas <- read_html("https://www.cbssports.com/mlb/teams")
areastitle <- c(".title td , td > a+ a")
Areas <- html_nodes(areas,areastitle)
Areas <- html_text(Areas)
Areas <- iconv(Areas,"UTF-8")
#Areas

df2 <- data.frame(union(Areas[2:16] ,Areas[18:32]))
df2$Areas[1:15] <- Areas[1]
df2$Areas[16:30] <- Areas[17]
names(df2) <- c("Team","Area")
df <- merge(df, df2, by = "Team")
#更多數據 ex:2B 3B 盜壘 被三振
stats <- read_html("https://www.baseball-reference.com/leagues/MLB/2017.shtml")
statstitle <- c("#teams_standard_batting tbody .right:nth-child(17) , #teams_standard_batting tbody .right:nth-child(14) , #teams_standard_batting tbody td.left")
stat <- html_nodes(stats,statstitle)
stat <- html_text(stat)
stat <- iconv(stat,"UTF-8")
#stat
count <- 1
Double <- c()
Triple <- c()
Stolen <- c()
Strikeout <- c()
while(count <= 120){
  if(count %% 4 == 0){
    Strikeout[count / 4 ] <- stat[count]
  }else if(count %% 4 == 1){
    Double[count / 4 + 1] <- stat[count]
  }else if(count %% 4 == 2){
    Triple[count / 4 + 1] <- stat[count]
  }else{
    Stolen[count / 4 + 1] <- stat[count]
  }
  count <- count + 1
}
df$Double <- as.numeric(Double)
df$Triple <- as.numeric(Triple)
df$Stolen <- as.numeric(Stolen)
df$Strikeout <- as.numeric(Strikeout)
df$Wins <- as.numeric(as.character(df$Wins))
df$HR <- as.numeric(as.character(df$HR))
cor(df$Batting,df$Win)

