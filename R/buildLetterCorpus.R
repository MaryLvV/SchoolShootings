setwd("~/GIT/SchoolShootings")
library(feather)
library(tm)
library(lubridate)
library(stringi)
library(stringr)

letters <- read_feather('letters.feather')

#make the date column an actual date, change to lower case and remove stop words 
#while preserving original letter text; get word counts for transformed letter column
letters$datetime <- parse_date_time(letters$datetime, "mdY")
letters$letterNSW <- tolower(letters$letter)
letters$letterNSW <- removeWords(letters$letterNSW, stopwords("english"))
letters$letterNSW <- str_replace_all(letters$letterNSW, "[^[A-Za-z ]]", "")
letters$wordcount <- vapply(strsplit(letters$letterNSW, "\\W+"), length, integer(1))

#calculate raw and adjusted sentiment values
library(syuzhet)
letters$feels <- get_nrc_sentiment(letters$letterNSW)
letters$anger_adj <- letters$feels$anger/letters$wordcount
letters$anticipation_adj <- letters$feels$anticipation/letters$wordcount
letters$disgust_adj <- letters$feels$disgust/letters$wordcount
letters$fear_adj <- letters$feels$fear/letters$wordcount
letters$joy_adj <- letters$feels$joy/letters$wordcount
letters$sadness_adj <- letters$feels$sadness/letters$wordcount
letters$surprise_adj <- letters$feels$surprise/letters$wordcount
letters$trust_adj <- letters$feels$trust/letters$wordcount
letters$negative_adj <- letters$feels$negative/letters$wordcount
letters$positive_adj <- letters$feels$positive/letters$wordcount
save(letters, file = 'letters_feels.rda')

