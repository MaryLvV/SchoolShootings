setwd("~/Lipscomb/mass_shooting/twitter")
rm(list = ls())
source('~/Lipscomb/mass_shooting/twitter/translate_emojis.R')

library(tm)
library(lubridate)
#library(stringi)
library(stringr)
library(syuzhet)

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

#need this function so stemming will work
stemfix <- function(x)
{
  as.character(paste(wordStem(unlist(strsplit(as.character(x), " "))),collapse=' '))
}

#remove retweets
#VT remains 1180
VT_tweets$retweet <- substr(VT_tweets$tweet, 1, 2) == 'RT'
VT_tweets <- subset(VT_tweets, retweet == FALSE)
VT_tweets <- VT_tweets[,1:2]
#replace emoji with word equivalents, remove stopwords and non-alpha characters
VT_tweets$tweet_formatted <- translate_emojis(VT_tweets$tweet)
VT_tweets$tweet_formatted <- tolower(VT_tweets$tweet_formatted)
VT_tweets$tweet_formatted <- removeWords(VT_tweets$tweet_formatted, stopwords("english"))
VT_tweets$tweet_formatted <- str_replace_all(VT_tweets$tweet_formatted, "[^[A-Za-z ]]", "")
VT_tweets$letter_formatted <- lapply(VT_tweets$letter_formatted, function(x) stemfix(x))

#calulate word count, add source and event columns
VT_tweets$wordcount <- vapply(strsplit(VT_tweets$tweet_formatted, "\\W+"), length, integer(1))
VT_tweets$source <- "twitter"
VT_tweets$event <- "VT"

#UCC dropped from 208,034 to 82,000
UCC_tweets$retweet <- substr(UCC_tweets$tweet, 1, 2) == 'RT'
UCC_tweets <- subset(UCC_tweets, retweet == FALSE)
UCC_tweets <- UCC_tweets[,1:2]

#replace emoji with word equivalents, remove stopwords and non-alpha characters
UCC_tweets$tweet_formatted <- translate_emojis(UCC_tweets$tweet)
UCC_tweets$tweet_formatted <- tolower(UCC_tweets$tweet_formatted)
UCC_tweets$tweet_formatted <- removeWords(UCC_tweets$tweet_formatted, stopwords("english"))
UCC_tweets$tweet_formatted <- str_replace_all(UCC_tweets$tweet_formatted, "[^[A-Za-z ]]", "")

#calulate word count, add source and event columns
UCC_tweets$wordcount <- vapply(strsplit(UCC_tweets$tweet_formatted, "\\W+"), length, integer(1))
UCC_tweets$source <- "twitter"
UCC_tweets$event <- "UCC"

#SH dropped from 1,139,751 to 597,835
SH_tweets$retweet <- substr(SH_tweets$tweet, 1, 2) == 'RT'
SH_tweets <- subset(SH_tweets, retweet == FALSE)
SH_tweets <- SH_tweets[,1:2]

#replace emoji with word equivalents, remove stopwords and non-alpha characters
SH_tweets$tweet_formatted <- translate_emojis(SH_tweets$tweet)
SH_tweets$tweet_formatted <- tolower(SH_tweets$tweet_formatted)
SH_tweets$tweet_formatted <- removeWords(SH_tweets$tweet_formatted, stopwords("english"))
SH_tweets$tweet_formatted <- str_replace_all(SH_tweets$tweet_formatted, "[^[A-Za-z ]]", "")

#calulate word count, add source and event columns
SH_tweets$wordcount <- vapply(strsplit(SH_tweets$tweet_formatted, "\\W+"), length, integer(1))
SH_tweets$source <- "twitter"
SH_tweets$event <- "SH"

#assign nrc sentiment scores, calculate normalized scores
VT_tweets$feels <- get_nrc_sentiment(VT_tweets$tweet_formatted)
VT_tweets$anger_adj <- VT_tweets$feels$anger/VT_tweets$wordcount
VT_tweets$anticipation_adj <- VT_tweets$feels$anticipation/VT_tweets$wordcount
VT_tweets$disgust_adj <- VT_tweets$feels$disgust/VT_tweets$wordcount
VT_tweets$fear_adj <- VT_tweets$feels$fear/VT_tweets$wordcount
VT_tweets$joy_adj <- VT_tweets$feels$joy/VT_tweets$wordcount
VT_tweets$sadness_adj <- VT_tweets$feels$sadness/VT_tweets$wordcount
VT_tweets$surprise_adj <- VT_tweets$feels$surprise/VT_tweets$wordcount
VT_tweets$trust_adj <- VT_tweets$feels$trust/VT_tweets$wordcount
VT_tweets$negative_adj <- VT_tweets$feels$negative/VT_tweets$wordcount
VT_tweets$positive_adj <- VT_tweets$feels$positive/VT_tweets$wordcount

#assign nrc sentiment scores, calculate normalized scores
UCC_tweets$feels <- get_nrc_sentiment(UCC_tweets$tweet_formatted)
UCC_tweets$anger_adj <- UCC_tweets$feels$anger/UCC_tweets$wordcount
UCC_tweets$anticipation_adj <- UCC_tweets$feels$anticipation/UCC_tweets$wordcount
UCC_tweets$disgust_adj <- UCC_tweets$feels$disgust/UCC_tweets$wordcount
UCC_tweets$fear_adj <- UCC_tweets$feels$fear/UCC_tweets$wordcount
UCC_tweets$joy_adj <- UCC_tweets$feels$joy/UCC_tweets$wordcount
UCC_tweets$sadness_adj <- UCC_tweets$feels$sadness/UCC_tweets$wordcount
UCC_tweets$surprise_adj <- UCC_tweets$feels$surprise/UCC_tweets$wordcount
UCC_tweets$trust_adj <- UCC_tweets$feels$trust/UCC_tweets$wordcount
UCC_tweets$negative_adj <- UCC_tweets$feels$negative/UCC_tweets$wordcount
UCC_tweets$positive_adj <- UCC_tweets$feels$positive/UCC_tweets$wordcount

#assign nrc sentiment scores, calculate normalized scores
SH_tweets$feels <- get_nrc_sentiment(SH_tweets$tweet_formatted)
SH_tweets$anger_adj <- SH_tweets$feels$anger/SH_tweets$wordcount
SH_tweets$anticipation_adj <- SH_tweets$feels$anticipation/SH_tweets$wordcount
SH_tweets$disgust_adj <- SH_tweets$feels$disgust/SH_tweets$wordcount
SH_tweets$fear_adj <- SH_tweets$feels$fear/SH_tweets$wordcount
SH_tweets$joy_adj <- SH_tweets$feels$joy/SH_tweets$wordcount
SH_tweets$sadness_adj <- SH_tweets$feels$sadness/SH_tweets$wordcount
SH_tweets$surprise_adj <- SH_tweets$feels$surprise/SH_tweets$wordcount
SH_tweets$trust_adj <- SH_tweets$feels$trust/SH_tweets$wordcount
SH_tweets$negative_adj <- SH_tweets$feels$negative/SH_tweets$wordcount
SH_tweets$positive_adj <- SH_tweets$feels$positive/SH_tweets$wordcount

#save files 
save(VT_tweets, file = 'vt_tweets_feels.rda')
save(UCC_tweets, file = 'ucc_tweets_feels.rda')
save(SH_tweets, file = 'sh_tweets_feels.rda')
