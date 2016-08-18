setwd("~/Lipscomb/mass_shooting")
rm(list = ls())
load('all_messages.rda')

library(dplyr)
library(reshape2)
library(ggplot2)
library (e1071)

all_messages.by_date <- all_messages %>% group_by(date) %>% summarise(total = n())
all_messages.by_event <- all_messages %>% group_by(event) %>% summarise(total = n())

all_messages.by_source <- all_messages %>% group_by(source) %>% summarise(total = n())
all_messages.by_source.type <- all_messages %>% group_by(source.type) %>% summarise(total = n())

#newspaper letters by event
AJC <- filter(all_messages, source == "AJC")
AJC_grouped <- group_by(AJC, event)
AJC_counts <- summarise(AJC_grouped, count = n())

DP <- filter(all_messages, source == "DeP")
DP_grouped <- group_by(DP, event)
DP_counts <- summarise(DP_grouped, count = n())

DMR <- filter(all_messages, source == "DMR")
DMR_grouped <- group_by(DMR, event)
DMR_counts <- summarise(DMR_grouped, count = n())

NYT <- filter(all_messages, source == "NYT")
NYT_grouped <- group_by(NYT, event)
NYT_counts <- summarise(NYT_grouped, count = n())

OS <- filter(all_messages, source == "OrS")
OS_grouped <- group_by(OS, event)
OS_counts <- summarise(OS_grouped, count = n())

SFC <- filter(all_messages, source == "SFC")
SFC_grouped <- group_by(SFC, event)
SFC_counts <- summarise(SFC_grouped, count = n())


#Create summary dataset for shiny and significance testing
event_source <- group_by(all_messages, event, source.type)
event_all <- group_by(all_messages, event)

anger_index <- summarise(event_source, anger = mean(anger_adj))
anger_all <- summarise(event_all, anger = mean(anger_adj))

disgust_index <- summarise(event_source, disgust = mean(disgust_adj))
disgust_all <- summarise(event_all, disgust = mean(disgust_adj))

fear_index <- summarise(event_source, fear = mean(fear_adj))
fear_all <- summarise(event_all, fear = mean(fear_adj))

sadness_index <- summarise(event_source, sadness = mean(sadness_adj))
sadness_all <- summarise(event_all, sadness = mean(sadness_adj))

surprise_index <- summarise(event_source, surprise = mean(surprise_adj))
surprise_all <- summarise(event_all, surprise = mean(surprise_adj))

all_sentiment <- merge(anger_all, fear_all)
all_sentiment <- merge(all_sentiment, disgust_all)
all_sentiment <- merge(all_sentiment, sadness_all)
all_sentiment <- merge(all_sentiment, surprise_all)
all_sentiment <- all_sentiment %>% melt
names(all_sentiment) <- c("event", "sentiment", "score")
all_sentiment$event_order <- c(2, 1, 4, 5, 3,
                               2, 1, 4, 5, 3,
                               2, 1, 4, 5, 3,
                               2, 1, 4, 5, 3,
                               2, 1, 4, 5, 3)

save(all_sentiment, file = 'all_sentiment.rda')
    
negative_index <- summarise(event_source, negative = mean(negative_adj))

counts <- summarise(event_source, count = n())

for_shiny <- merge(anger_index, disgust_index)
for_shiny <- merge(for_shiny, fear_index)
for_shiny <- merge(for_shiny, disgust_index)
for_shiny <- merge(for_shiny, sadness_index)
for_shiny <- merge(for_shiny, surprise_index)
for_shiny <- merge(for_shiny, negative_index)
for_shiny <- merge(for_shiny, counts)

#save(for_shiny, file = 'summaries.rda')
load(file = 'summaries.rda')

sentiment_grouped <- group_by(for_shiny, event, source.type)
sentiment_grouped$date.event <- c( '2006-10-02', '1999-04-20', 
                                   '2012-12-14', '2012-12-14', 
                                   '2015-10-01', '2015-10-01', 
                                   '2007-04-16', '2007-04-16')
sentiment_grouped$date.event <- as.Date(sentiment_grouped$date.event)

avg_sentiment <- summarise(sentiment_grouped,
                           anger = anger,
                           disgust = disgust,
                           fear =  fear,
                           sadness = sadness,
                           surprise = surprise)%>% melt
names(avg_sentiment) <- c('event', 'source', 'sentiment', 'score')
vt_sentiment <- subset(avg_sentiment, event == 'VT')
ucc_sentiment <- subset(avg_sentiment, event == 'UCC')
sh_sentiment <- subset(avg_sentiment, event == 'SH')
ami_sentiment <- subset(avg_sentiment, event == 'AMI')
chs_sentiment <- subset(avg_sentiment, event == 'CHS')

avg_sentiment$event_order <- c(2,1,4,4,5,5,3,3,2,1,4,4,5,5,3,3,2,1,4,4,5,5,3,3,2,1,4,4,5,5,3,3,2,1,4,4,5,5,3,3)
avg_sentiment$event_order <- as.integer(avg_sentiment$event_order)

save(avg_sentiment, file = 'avg_sentiment.rda')

avg_letter_sentiment <- subset(avg_sentiment, source == 'Letter')
avg_twitter_sentiment <- subset(avg_sentiment, source == 'Twitter')

#anger
letter_anger <- subset(avg_letter_sentiment, sentiment == 'anger')
twitter_anger <- subset(avg_twitter_sentiment, sentiment == 'anger')
plot(letter_anger$event_order, letter_anger$score)
plot(twitter_anger$event_order, twitter_anger$score)

#sadness
letter_sadness <- subset(avg_letter_sentiment, sentiment == 'sadness')
twitter_sadness <- subset(avg_twitter_sentiment, sentiment == 'sadness')
plot(letter_sadness$event_order, letter_sadness$score)
plot(twitter_sadness$event_order, twitter_sadness$score)

#fear
letter_fear <- subset(avg_letter_sentiment, sentiment == 'fear')
twitter_fear <- subset(avg_twitter_sentiment, sentiment == 'fear')
plot(letter_fear$event_order, letter_fear$score)
plot(twitter_fear$event_order, twitter_fear$score)

#disgust
letter_disgust <- subset(avg_letter_sentiment, sentiment == 'disgust')
twitter_disgust <- subset(avg_twitter_sentiment, sentiment == 'disgust')
plot(letter_disgust$event_order, letter_disgust$score)
plot(twitter_disgust$event_order, twitter_disgust$score)

#surprise
letter_surprise <- subset(avg_letter_sentiment, sentiment == 'surprise')
twitter_surprise <- subset(avg_twitter_sentiment, sentiment == 'surprise')
plot(letter_surprise$event_order, letter_surprise$score)
plot(twitter_surprise$event_order, twitter_surprise$score)




