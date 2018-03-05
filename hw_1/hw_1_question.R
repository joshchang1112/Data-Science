### hw_1_question


########################################################### Task 1

# 查看內建資料集: 鳶尾花(iris)資料集
iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列
head(iris)

# 使用tail() 回傳iris的後六列
tail(iris)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)

########################################################### Task 2

# 使用for loop 印出九九乘法表
# Ex: (1x1=1 1x2=2...1x9=9 ~ 9x1=9 9x2=18... 9x9=81)
for (x in (1:9)){
  for(y in (1:9)){
    answer2 <- paste(x, "x", y, "=", x*y)
    print(answer2)
  }
}


########################################################### Task 3
# 使用sample(), 產出10個介於10~100的整數，並存在變數 nums
nums = sample(10:100, size = 10)
# 查看nums
nums

# 1.使用for loop 以及 if-else，印出大於50的偶數，並提示("偶數且大於50": 數字value)
# 2.特別規則：若數字為66，則提示("太66666666666了")並中止迴圈。

for(x in (1:10)){
  if(nums[x] > 50 && nums[x] %% 2 == 0){
    print(nums[x])
    answer3 <- paste("偶數且大於50:" , nums[x])
    print(answer3)
    if(nums[x] == 66){
      print("太66666666666了")
      break()
    }
  }
}


########################################################### Task 4

# 請寫一段程式碼，能判斷輸入之西元年分 year 是否為閏年

year <- scan()
if(year %% 4 == 0 && (year %% 100 != 0) || (year %% 400 == 0) && (year %% 3200 != 0)){
  answer4 <- paste(year,'年是閏年！')
  print(answer4)
}else{
  answer4 <- paste(year,'年是平年！')
  print(answer4)
}




########################################################### Task 5

# 猜數字遊戲
# 1. 請寫一個由電腦隨機產生不同數字的四位數(1A2B遊戲)
# 2. 玩家可重覆猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

#初始化
number <- c()
check <- c(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE)

#產生一個不同數字的四位數
number = sample(0:9, size = 4)
number
guesstime <- 0
bingo <- 0
fakebingo <- 0
separate_num <- c()
#進行猜的階段

while(bingo != 4){
  bingo <- 0
  fakebingo <- 0
  guesstime = guesstime + 1
  guessnumber = scan()
  separate_num[1] <- guessnumber %/% 1000
  guessnumber = guessnumber %% 1000
  separate_num[2] <- guessnumber %/% 100
  guessnumber = guessnumber %% 100
  separate_num[3] <- guessnumber %/% 10
  separate_num[4] = guessnumber %% 10
  for(i in (1:4)){
    for(j in (1:4)){
      if(separate_num[i] == number[j]){
        if(i == j){
          bingo <- bingo +1
        }else{
          fakebingo <- fakebingo + 1
        }
      }
    }
  }
  instruction = paste(bingo, "A", fakebingo, "B")
  print(instruction)
}

answer5 = paste("總共猜了", guesstime, "次")
print(answer5)



