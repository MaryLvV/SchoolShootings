setwd("~/Lipscomb/mass_shooting/twitter")
rm(list = ls())

library(tm)
library(lubridate)
library(stringi)
library(stringr)

load('vt_tweets.rda')
load('ucc_tweets.rda')
load('sh_tweets.rda')

#VT 1180; UCC 208,034; SH 1,139,751
# all_tweets <- merge(VT_tweets, UCC_tweets, all = TRUE)
# all_tweets <- merge(all_tweets, SH_tweets, all = TRUE)

# twitterCorpus = Corpus(VectorSource(all_tweets$tweet))
# inspect(twitterCorpus)

#convert datetime to datetime format
VT_tweets$datetime <- parse_date_time(VT_tweets$datetime, "Ymd HMS")
UCC_tweets$datetime <- parse_date_time(UCC_tweets$datetime, "Ymd HMS")
SH_tweets$datetime <- parse_date_time(SH_tweets$datetime, "Ymd HMS")

#remove retweets
#VT remains 1180
VT_tweets$retweet <- substr(VT_tweets$tweet, 1, 2) == 'RT'
VT_tweets <- subset(VT_tweets, retweet == FALSE)
VT_tweets <- VT_tweets[,1:2]
VT_tweets$tweet <- str_replace_all(VT_tweets$tweet, "[^[A-Za-z ]]", "")
VT_tweets$wordcount <- vapply(strsplit(VT_tweets$tweet, "\\W+"), length, integer(1))
VT_tweets$source <- "twitter"
VT_tweets$event <- "VT"

#UCC dropped from 208,034 to 82,000
UCC_tweets$retweet <- substr(UCC_tweets$tweet, 1, 2) == 'RT'
UCC_tweets <- subset(UCC_tweets, retweet == FALSE)
UCC_tweets <- UCC_tweets[,1:2]
UCC_tweets$tweet <- str_replace_all(UCC_tweets$tweet, "[^[A-Za-z ]]", "")
UCC_tweets$wordcount <- vapply(strsplit(UCC_tweets$tweet, "\\W+"), length, integer(1))
UCC_tweets$source <- "twitter"
UCC_tweets$event <- "UCC"

#SH dropped from 1,139,751 to 597,835
SH_tweets$retweet <- substr(SH_tweets$tweet, 1, 2) == 'RT'
SH_tweets <- subset(SH_tweets, retweet == FALSE)
SH_tweets <- SH_tweets[,1:2]
SH_tweets$tweet <- str_replace_all(SH_tweets$tweet, "[^[A-Za-z ]]", "")
SH_tweets$wordcount <- vapply(strsplit(SH_tweets$tweet, "\\W+"), length, integer(1))
SH_tweets$source <- "twitter"
SH_tweets$event <- "SH"

library(syuzhet)
VT_tweets$feels <- get_nrc_sentiment(VT_tweets$tweet)
UCC_tweets$feels <- get_nrc_sentiment(UCC_tweets$tweet)
SH_tweets$feels <- get_nrc_sentiment(SH_tweets$tweet)




#library(emojifont)
# find_emoji <- function(tweets){
#   emoji_tweets <- vector()
#   #emoji <- "U0001f6[0-9][0-9]f"
#   #emoji <- "🙏" 
#   for (tweet in tweets)  {
#     if (str_detect(toString(tweet), "U0001f6[0-9][0-9]f")) {
#       emoji_tweets <- append(emoji_tweets, tweet)
#     }
#   }
#   return(emoji_tweets)
# }
 
save(VT_tweets, file = 'vt_tweets_feels.rda')
save(UCC_tweets, file = 'ucc_tweets_feels.rda')
save(SH_tweets, file = 'sh_tweets_feels.rda')
