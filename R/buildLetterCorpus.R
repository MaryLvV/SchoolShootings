setwd("~/GIT/SchoolShootings")
library(feather)
library(tm)
library(lubridate)
library(stringr)

letters <- read_feather('R/letters.feather')

#make the date column an actual date, change to lower case and remove stop words 
#while preserving original letter text; get word counts for transformed letter column
letters$datetime <- parse_date_time(letters$datetime, "mdY")
letters$letter_formatted <- tolower(letters$letter)
letters$letter_formatted <- removeWords(letters$letter_formatted, stopwords("english"))
letters$letter_formatted <- str_replace_all(letters$letter_formatted, "[^[A-Za-z ]]", "")
letters$wordcount <- vapply(strsplit(letters$letter_formatted, "\\W+"), length, integer(1))

#calculate raw and adjusted sentiment values
library(syuzhet)
letters$feels <- get_nrc_sentiment(letters$letter_formatted)
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

