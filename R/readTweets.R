setwd("~/Lipscomb/mass_shooting/twitter")
rm(list = ls())
library(feather)

VT_tweets <- read_feather("tweets_df/vt_tweets.feather")
VT_tweets <- VT_tweets[, 1:2]
save(VT_tweets, file = 'vt_tweets.rda')
#View(VT_tweets)
UCC_tweets <- read_feather("tweets_df/umpqua_tweets.feather")
UCC_tweets <- UCC_tweets[, 1:2]
save(UCC_tweets, file = 'ucc_tweets.rda')

SH_tweets <- read_feather("tweets_df/sh_tweets.feather")
SH_tweets <- SH_tweets[, 1:2]
save(SH_tweets, file = 'sh_tweets.rda')





