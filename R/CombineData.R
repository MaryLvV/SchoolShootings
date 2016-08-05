setwd("~/Lipscomb/mass_shooting")
rm(list = ls())

load('twitter/vt_tweets_feels.rda')
load('twitter/ucc_tweets_feels.rda')
load('twitter/sh_tweets_feels.rda')
load('letter_feels.rda')

#use  consistent names
names(letters) <- c('message', 'datetime', 'source', 'event',
                    'formatted_message','wordcount',  
                    'feels', 'anger_adj', 'anticipation_adj', 
                    'disgust_adj', 'fear_adj', 'joy_adj', 
                    'sadness_adj', 'surprise_adj', 'trust_adj',
                    'negative_adj', 'positive_adj')

names(VT_tweets) <- c('message', 'datetime', 'formatted_message', 
                      'wordcount', 'source', 'event',
                      'feels', 'anger_adj', 'anticipation_adj', 
                      'disgust_adj', 'fear_adj', 'joy_adj', 
                      'sadness_adj', 'surprise_adj', 'trust_adj',
                      'negative_adj', 'positive_adj')

names(UCC_tweets) <- c('message', 'datetime', 'formatted_message', 
                       'wordcount', 'source', 'event',
                       'feels', 'anger_adj', 'anticipation_adj', 
                       'disgust_adj', 'fear_adj', 'joy_adj', 
                       'sadness_adj', 'surprise_adj', 'trust_adj',
                       'negative_adj', 'positive_adj')

names(SH_tweets) <- c('message', 'datetime', 'formatted_message', 
                      'wordcount', 'source', 'event',
                      'feels', 'anger_adj', 'anticipation_adj', 
                      'disgust_adj', 'fear_adj', 'joy_adj', 
                      'sadness_adj', 'surprise_adj', 'trust_adj',
                      'negative_adj', 'positive_adj')

#create subsets of the letters data to explore sentiment raw scores
VT_letters <- with (letters, subset(feels, event == 'VT'))
SH_letters <- with (letters, subset(feels, event == 'SH'))
UCC_letters <- with (letters, subset(feels, event == 'UCC'))
AMI_letters <- with (letters, subset(feels, event == 'AMI'))
CHS_letters <- with (letters, subset(feels, event == 'CHS'))

#word counts
range(letters$wordcount) #10 to 271
range(VT_tweets$wordcount) #2 to 21
range(SH_tweets$wordcount) #1 to 56
range(UCC_tweets$wordcount) #1 to 26

#Virginia Tech tweets
count(VT_tweets)  #1,180
range(VT_tweets$feels$anger, na.rm = TRUE)    #0 to 3
range(VT_tweets$feels$disgust, na.rm = TRUE)  #0 to 3
range(VT_tweets$feels$fear, na.rm = TRUE)     #0 to 4
range(VT_tweets$feels$sadness, na.rm = TRUE)  #0 to 3
range(VT_tweets$feels$surprise, na.rm = TRUE) #0 to 3 
range(VT_tweets$feels$negative, na.rm = TRUE) #0 to 4
#Virginia Tech letters
count(VT_letters)  #158
range(VT_letters$anger, na.rm = TRUE)    #0 to 16
range(VT_letters$disgust, na.rm = TRUE)  #0 to 13
range(VT_letters$fear, na.rm = TRUE)     #0 to 17
range(VT_letters$sadness, na.rm = TRUE)  #0 to 18
range(VT_letters$surprise, na.rm = TRUE) #0 to 7 
range(VT_letters$negative, na.rm = TRUE) #0 to 31

#Sandy Hook tweets
count(SH_tweets) #597,835
range(SH_tweets$feels$anger, na.rm = TRUE)    #0 to 6
range(SH_tweets$feels$disgust, na.rm = TRUE)  #0 to 7
range(SH_tweets$feels$fear, na.rm = TRUE)     #0 to 7
range(SH_tweets$feels$sadness, na.rm = TRUE)  #0 to 6
range(SH_tweets$feels$surprise, na.rm = TRUE) #0 to 4 
range(SH_tweets$feels$negative, na.rm = TRUE) #0 to 7
#Sandy Hook letters
count(SH_letters)  #93
range(SH_letters$anger, na.rm = TRUE)    #0 to 12
range(SH_letters$disgust, na.rm = TRUE)  #0 to 8
range(SH_letters$fear, na.rm = TRUE)     #0 to 13
range(SH_letters$sadness, na.rm = TRUE)  #0 to 12
range(SH_letters$surprise, na.rm = TRUE) #0 to 5 
range(SH_letters$negative, na.rm = TRUE) #0 to 17

#Umpqua Community College tweets
count(UCC_tweets) #82,000
range(UCC_tweets$feels$anger, na.rm = TRUE)    #0 to 6
range(UCC_tweets$feels$disgust, na.rm = TRUE)  #0 to 5
range(UCC_tweets$feels$fear, na.rm = TRUE)     #0 to 8
range(UCC_tweets$feels$sadness, na.rm = TRUE)  #0 to 5
range(UCC_tweets$feels$surprise, na.rm = TRUE) #0 to 5 
range(UCC_tweets$feels$negative, na.rm = TRUE) #0 to 7
#Umpqua Community College letters
count(UCC_letters)  #19
range(UCC_letters$anger, na.rm = TRUE)    #1 to 12
range(UCC_letters$disgust, na.rm = TRUE)  #0 to 7
range(UCC_letters$fear, na.rm = TRUE)     #2 to 11
range(UCC_letters$sadness, na.rm = TRUE)  #0 to 7
range(UCC_letters$surprise, na.rm = TRUE) #0 to 4 
range(UCC_letters$negative, na.rm = TRUE) #0 to 17

#Amish School letters
count(AMI_letters)  #18
range(AMI_letters$anger, na.rm = TRUE)    #0 to 10
range(AMI_letters$disgust, na.rm = TRUE)  #0 to 6
range(AMI_letters$fear, na.rm = TRUE)     #0 to 14
range(AMI_letters$sadness, na.rm = TRUE)  #0 to 9
range(AMI_letters$surprise, na.rm = TRUE) #0 to 3 
range(AMI_letters$negative, na.rm = TRUE) #1 to 15

#Columbine letters
count(CHS_letters)  #91
range(CHS_letters$anger, na.rm = TRUE)    #0 to 13
range(CHS_letters$disgust, na.rm = TRUE)  #0 to 11
range(CHS_letters$fear, na.rm = TRUE)     #0 to 15
range(CHS_letters$sadness, na.rm = TRUE)  #0 to 13
range(CHS_letters$surprise, na.rm = TRUE) #0 to 8 
range(CHS_letters$negative, na.rm = TRUE) #0 to 26


#drop the feels column so we can rbind all the dataframes
VT_tweets_adj <- subset(VT_tweets, select = c('message', 'datetime', 'formatted_message', 
                                              'wordcount', 'source', 'event',
                                              'anger_adj', 'anticipation_adj', 
                                              'disgust_adj', 'fear_adj', 'joy_adj', 
                                              'sadness_adj', 'surprise_adj', 'trust_adj',
                                              'negative_adj', 'positive_adj'))

UCC_tweets_adj <- subset(UCC_tweets, select = c('message', 'datetime', 'formatted_message', 
                                              'wordcount', 'source', 'event',
                                              'anger_adj', 'anticipation_adj', 
                                              'disgust_adj', 'fear_adj', 'joy_adj', 
                                              'sadness_adj', 'surprise_adj', 'trust_adj',
                                              'negative_adj', 'positive_adj'))

SH_tweets_adj <- subset(SH_tweets, select = c('message', 'datetime', 'formatted_message', 
                                                'wordcount', 'source', 'event',
                                                'anger_adj', 'anticipation_adj', 
                                                'disgust_adj', 'fear_adj', 'joy_adj', 
                                                'sadness_adj', 'surprise_adj', 'trust_adj',
                                                'negative_adj', 'positive_adj'))

letters_adj <- subset(letters, select = c('message', 'datetime', 'formatted_message', 
                                                'wordcount', 'source', 'event',
                                                'anger_adj', 'anticipation_adj', 
                                                'disgust_adj', 'fear_adj', 'joy_adj', 
                                                'sadness_adj', 'surprise_adj', 'trust_adj',
                                                'negative_adj', 'positive_adj'))

all_messages <- rbind(VT_tweets_adj, UCC_tweets_adj)
all_messages <- rbind(all_messages, SH_tweets_adj)
all_messages <- rbind(all_messages, letters_adj)

# add column to classify as newspaper or twitter source type & column for simple date
all_messages$source.type <- ifelse(all_messages$source == 'twitter', 'Twitter', 'Letter')
all_messages$date <- as.Date(all_messages$datetime)

save(all_messages, file = 'all_messages.rda')

