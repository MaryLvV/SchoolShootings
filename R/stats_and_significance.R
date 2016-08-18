load('all_messages.rda')
library (e1071)
library(stats)

my_stats <- function (x)  {
    cat("Mean = ", mean(x, na.rm = TRUE), "\n")
    cat("Median = ", median(x, na.rm = TRUE), "\n")
    cat("Skewness = ", skewness(x, na.rm = TRUE), "\n")
    cat("Standard Deviation = ", sd(x, na.rm = TRUE), "\n")
    cat ("Range is between ", range(x, na.rm = TRUE), "\n")
}

# 5000; 400,000,000; 500,000,000
twitter_sandy_hook <- filter(all_messages, event == 'SH', source == 'twitter')
twitter_virginia_tech <- filter(all_messages, event == 'VT', source == 'twitter')
twitter_umpqua <- filter(all_messages, event == 'UCC', source == 'twitter')


vt_tweets.by_date <- twitter_virginia_tech %>% group_by(date) %>% summarise(total = n())
vt_tweets.by_date$proportion <- vt_tweets.by_date$total/5000

sh_tweets.by_date <- twitter_sandy_hook %>% group_by(date) %>% summarise(total = n())
sh_tweets.by_date$proportion <- sh_tweets.by_date$total/400000000

ucc_tweets.by_date <- twitter_umpqua %>% group_by(date) %>% summarise(total = n())
ucc_tweets.by_date$proportion <- ucc_tweets.by_date$total/500000000

vt_tweets.by_date$days.from.event <- vt_tweets.by_date$date - as.Date('2007-04-16')
sh_tweets.by_date$days.from.event <- sh_tweets.by_date$date - as.Date('2012-12-14')
ucc_tweets.by_date$days.from.event <- ucc_tweets.by_date$date - as.Date('2015-10-01')

#proportion of twitter users tweeting about VT vs SH
t.test(vt_tweets.by_date$proportion, sh_tweets.by_date$proportion, alternative = "g")
# data:  vt_tweets.by_date$proportion and sh_tweets.by_date$proportion
# t = 2.6578, df = 27.001, p-value = 0.006526
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.003008556         Inf
# sample estimates:
#     mean of x    mean of y 
# 0.0084285714 0.0000515375

#proportion of twitter users tweeting about SH vs UCC
 t.test(ucc_tweets.by_date$proportion, sh_tweets.by_date$proportion, alternative = "l")
 # data:  ucc_tweets.by_date$proportion and sh_tweets.by_date$proportion
 # t = -4.0666, df = 31.246, p-value = 0.0001501
 # alternative hypothesis: true difference in means is less than 0
 # 95 percent confidence interval:
 #     -Inf -2.675689e-05
 # sample estimates:
 #     mean of x    mean of y 
 # 5.655172e-06 5.153750e-05 


sh <- subset(all_messages, event == 'SH')
vt <- subset(all_messages, event == 'VT')
ucc <- subset(all_messages, event == 'UCC')
chs <- subset(all_messages, event == 'CHS')
ami <- subset(all_messages, event == 'AMI')

chs_avg <- mean(chs$anger_adj)
ami_avg <- mean(ami$anger_adj)
vt_avg <- mean(vt$anger_adj)
sh_avg <- mean(sh$anger_adj)
ucc_avg <- mean(ucc$anger_adj)

anger.over.time <- data.frame(
    date = all_messages$date,
    anger = all_messages$anger_adj)



#boxplot and stats for anger across all events
boxplot(all_messages$anger_adj, col = "light blue", horizontal = TRUE,varwidth = TRUE)
my_stats(all_messages$anger)
# Mean =  0.04472412 
# Median =  0 
# Skewness =  1.41531 
# Standard Deviation =  0.06245346 
# Range is between  0 0.6666667 

#t-test for significance between letters and tweets anger scores
tweets <- subset(all_messages, source.type == "Twitter")
letters <- subset(all_messages, source.type == "Letter")

tweet.anger <- tweets$anger_adj
letter.anger <- letters$anger_adj
t.test(letter.anger, tweet.anger, alternative ="g")
# data:  letter.anger and tweet.anger
# t = 9.1543, df = 379.39, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.01326757        Inf
# sample estimates:
#     mean of x  mean of y 
# 0.06089746 0.04471512 


tweet.sadness <- tweets$sadness_adj
letter.sadness <- letters$sadness_adj
t.test(letter.sadness, tweet.sadness, alternative = "g")
# data:  letter.sadness and tweet.sadness
# t = 10.972, df = 379, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.01650309        Inf
# sample estimates:
#     mean of x  mean of y 
# 0.05030096 0.03087908 

tweet.disgust <- tweets$disgust_adj
letter.disgust <- letters$disgust_adj
t.test(letter.disgust, tweet.disgust, alternative = "g")
# data:  letter.disgust and tweet.disgust
# t = 9.6111, df = 379.09, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.009705529         Inf
# sample estimates:
#     mean of x  mean of y 
# 0.02618946 0.01447403 

tweet.fear <- tweets$fear_adj
letter.fear <- letters$fear_adj
t.test(letter.fear, tweet.fear, alternative = "g")
# data:  letter.fear and tweet.fear
# t = 8.7403, df = 379.22, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.01518158        Inf
# sample estimates:
#     mean of x  mean of y 
# 0.07741966 0.05870810

tweet.surprise <- tweets$surprise_adj
letter.surprise <- letters$surprise_adj
t.test(letter.surprise, tweet.surprise, alternative = "g")
# data:  letter.surprise and tweet.surprise
# t = 9.2149, df = 378.84, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.009311264         Inf
# sample estimates:
#     mean of x  mean of y 
# 0.02305434 0.01171383  


#t-test for significance between Sandy Hook anger and Umpqua anger
SandyHook.anger <- sh$anger_adj
Umpqua.anger <- ucc$anger_adj
t.test(Umpqua.anger, SandyHook.anger, alternative = "g")

# Welch Two Sample t-test
# 
# data:  Umpqua.anger and SandyHook.anger
# t = 93.156, df = 101120, p-value < 2.2e-16
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#     0.02285762        Inf
# sample estimates:
#     mean of x  mean of y 
# 0.06516975 0.04190128
