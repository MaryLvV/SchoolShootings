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
save(sh_tweets, file = 'sh_tweets.rda')


# sh1 <- read_feather("tweets_df/sh1.feather")
# sh2 <- read_feather("tweets_df/sh2.feather")
# sh3 <- read_feather("tweets_df/sh3.feather")
# #sh4 <- read_feather("tweets_df/sh4.feather")
# sh4a <- read_feather("tweets_df/sh4a.feather")
# sh4b <- read_feather("tweets_df/sh4b.feather")
# sh5 <- read_feather("tweets_df/sh5.feather")
# sh6 <- read_feather("tweets_df/sh6.feather")
# #sh7 <- read_feather("tweets_df/sh7.feather")
# sh7a <- read_feather("tweets_df/sh7a.feather")
# sh7b <- read_feather("tweets_df/sh7b.feather")
# sh8 <- read_feather("tweets_df/sh8.feather")
# 
# sh_tweets <- merge(sh1,sh2, all = TRUE)
# sh_more <- merge(sh3, sh5, all = TRUE)
# sh_tweets <- merge(sh_tweets, sh_more, all = TRUE)
# sh_more <- merge(sh4a, sh4b, all = TRUE)
# sh_tweets <- merge(sh_tweets, sh_more, all = TRUE)
# sh_more <- merge(sh7a, sh7b, all = TRUE)
# sh_tweets <- merge(sh_tweets, sh_more, all = TRUE)
# sh_more <- merge(sh6, sh8, all = TRUE)
# sh_tweets <- merge(sh_tweets, sh_more, all = TRUE)
# save(sh_tweets, file = 'sh_tweets.rda')
