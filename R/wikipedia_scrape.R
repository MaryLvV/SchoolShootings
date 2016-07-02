library(htmltab)

clean_cell <- function(node) {
  cell_content <- XML::xmlValue(node) 
  with_clean_dates <- sub('^0+\\d{4}-\\d{2}-\\d{2}-0+', '', cell_content)
  with_clean_location <- sub('^.*\\s!(.*)', '\\1', with_clean_dates)
}

get_table <- function(index)  {
  htmltab(
    doc = "https://en.wikipedia.org/wiki/List_of_school_shootings_in_the_United_States",
    which = paste0('//*[@id="mw-content-text"]/table[', index, ']'),
    bodyFun = clean_cell)
}

all_tables <- function (table_count) {
  combined <- data.frame()   
  for (index in 1:table_count) {
    combined <- merge(combined, get_table(index), all=TRUE)
  }
  return (combined)
}

# all_tables_reduce <- function (table_count) {
#   Reduce(function (acc, index) {
#     merge(acc, get_table(index), all=TRUE)
#   }, (1:table_count), INIT=data.frame())
# }

us_school_shootings <- all_tables(18)
us_school_shootings <- rbind(us_school_shootings, c('July 26, 1764', 'Greencastle, Pennsylvania', 10, 2, "Enoch Brown school massacre: Perhaps the earliest shooting to happen on school or college property, in what would become the United States, was the notorious Enoch Brown school massacre during the Pontiac's War. Three men entered the schoolhouse near present-day Greencastle, Pennsylvania, shot and killed schoolmaster Enoch Brown, and nine children (reports vary). Only three children survived."))

us_school_shootings$Date <- as.Date(us_school_shootings$Date, format = "%B %d, %Y")
us_school_shootings$Deaths <- as.numeric(us_school_shootings$Deaths)
us_school_shootings$Injuries <- as.numeric(us_school_shootings$Injuries)

# save dataframe
save(us_school_shootings, file = "all_school_shootings.rda")

setwd("~/Lipscomb/mass_shooting")
# load saved dataframe
load(file = "all_school_shootings.rda")

# create a subset where 4 or more deaths occured 
mass_school_shootings <- subset(us_school_shootings, Deaths > 3)
# mass_school_shootings$state <- sub('^.*\\, ', '', mass_school_shootings$Location)
# mass_school_shootings$city <- sub('^(.*)\\, [A-Za-z]+', '\\1', mass_school_shootings$Location)
# mass_school_shootings$city[5] <- "Charles Town"

twitter_shootings <- subset(mass_school_shootings, Date > '2007-01-01')

library(ggmap)
mass_school_shootings$lonlat <- geocode(unique(mass_school_shootings$Location)) 

library(plotrix)
mass_school_shootings$Freq <- rescale(mass_school_shootings$Deaths, c(4,33)) # c(scale_min, scale_max)


library(ggplot2)
us <- map_data("state")
us <- fortify(us, region="region")
gg <- ggplot()
gg <- gg + geom_map(data=us, map=us,
                   aes(x=long, y=lat, map_id=region, group=group),
                   fill="#ffffff", color="#7f7f7f", size=0.25)
gg <- gg + geom_point(data=mass_school_shootings, 
                      aes(x=lonlat$lon, y=lonlat$lat, size=Freq), 
                      colour="red")
gg <- gg + geom_text(data=mass_school_shootings, 
                     aes(x=lonlat$lon, y=lonlat$lat, 
                         label=mass_school_shootings$Location), 
                     vjust=1, colour="black", alpha=.5)
gg <- gg + theme(legend.position="right")
gg

#timeline
qplot(mass_school_shootings$Date, bins = 50, xlab = '', ylab = 'Number of events', main = 'Mass School Shootings in the U.S.')

#twitter timeline
qplot(twitter_shootings$Date, bins = 40, binwidth = 200,  xlab = '', ylab = '', main = 'Twitter era mass school shootings', fill = twitter_shootings$data)

