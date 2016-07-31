#http://apps.timwhitlock.info/emoji/tables/unicode

translate_emojis <- function(my_content)  {
  
  emojis <- vector(mode = "list", length = 58)
  emojis <- c("😁", "😂", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😌", "😍", 
             "😏", "😒", "😓", "😔", "😖", "😘", "😚", "😜", "😝", "😞", "😠",
             "😡", "😢", "😣", "😤", "😥", "😨", "😩", "😪", "😫", "😭", "😰",
             "😱", "😲", "😳", "😵", "😷", "😸", "😹", "😺", "😻", "😼", "😽",
             "😾", "😿", "🙀", "🙅", "🙆", "🙇", "🙈", "🙉", "🙊", "🙋", "🙌",
             "🙍", "🙎", "🙏")
  
  names(emojis) <- c('grinning', 'tears_of_joy', 'smiling', 'smiling2', 'smiling3', 'smiling4', 
                     'winking','smiling5', 'delicious', 'relieved', 'smiling_heart', 'smirking', 
                     'unamused', 'cold_sweat', 'pensive', 'confounded', 'kiss', 'kiss2', 'tongue_out',
                     'tongue_out2', 'disappointed', 'angry', 'pouting', 'crying', 'persevering',
                     'triumph', 'disappointed_relieved', 'fearful', 'weary', 'sleepy', 'tired', 
                     'bawling', 'cold_sweat', 'screaming_fear', 'astonished', 'flushed','dizzy',
                     'medical_mask', 'grinning2', 'tears_of_joy2', 'smiling6', 'smiling_heart2', 
                     'smiling_wry', 'kiss3', 'pouting2', 'crying2', 'weary2', 'no_good', 'okay', 
                     'bowing', 'see_no_evil', 'hear_no_evil', 'say_no_evil', 'happy', 'celebration', 
                     'frowning', 'pouting3', 'praying')
  
  my_content <- gsub(emojis['grinning'], ' grinning ', my_content)
  my_content <- gsub(emojis['tears_of_joy'], ' joy ', my_content)
  my_content <- gsub(emojis['smiling'], ' smiling ', my_content)
  my_content <- gsub(emojis['smiling2'], ' smiling ', my_content)
  my_content <- gsub(emojis['smiling3'], ' smiling ', my_content)
  my_content <- gsub(emojis['smiling4'], ' smiling ', my_content)
  my_content <- gsub(emojis['winking'], ' winking ', my_content)
  my_content <- gsub(emojis['smiling5'], ' smiling ', my_content)
  my_content <- gsub(emojis['delicious'], ' delicious ', my_content)
  my_content <- gsub(emojis['relieved'], ' relieved ', my_content)
  my_content <- gsub(emojis['smiling_heart'], ' smiling ', my_content)
  my_content <- gsub(emojis['smirking'], ' smirking ', my_content)
  my_content <- gsub(emojis['unamused'], ' unamused ', my_content)
  my_content <- gsub(emojis['cold_sweat'], ' cold sweat ', my_content)
  my_content <- gsub(emojis['pensive'], ' pensive ', my_content)
  my_content <- gsub(emojis['confounded'], ' confounded ', my_content)
  my_content <- gsub(emojis['kiss'], ' kiss ', my_content)
  my_content <- gsub(emojis['kiss2'], ' kiss ', my_content)
  my_content <- gsub(emojis['tongue_out'], ' taunt ', my_content)
  my_content <- gsub(emojis['tongue_out2'], ' taunt ', my_content)
  my_content <- gsub(emojis['disappointed'], ' disappointed ', my_content)
  my_content <- gsub(emojis['angry'], ' angry ', my_content)
  my_content <- gsub(emojis['pouting'], ' pouting ', my_content)
  my_content <- gsub(emojis['crying'], ' crying ', my_content)
  my_content <- gsub(emojis['persevering'], ' persevering ', my_content)
  my_content <- gsub(emojis['triumph'], ' triumph ', my_content)
  my_content <- gsub(emojis['disappointed_relieved'], ' disappointed relieved ', my_content)
  my_content <- gsub(emojis['fearful'], ' fearful ', my_content)
  my_content <- gsub(emojis['weary'], ' weary ', my_content)
  my_content <- gsub(emojis['sleepy'], ' sleepy ', my_content)
  my_content <- gsub(emojis['tired'], ' tired ', my_content)
  my_content <- gsub(emojis['bawling'], ' bawling ', my_content)
  my_content <- gsub(emojis['cold_sweat'], ' cold sweat ', my_content)
  my_content <- gsub(emojis['screaming_fear'], ' screaming fear ', my_content)
  my_content <- gsub(emojis['astonished'], ' astonished ', my_content)
  my_content <- gsub(emojis['flushed'], ' flushed ', my_content)
  my_content <- gsub(emojis['dizzy'], ' dizzy ', my_content)
  my_content <- gsub(emojis['medical_mask'], ' medical ', my_content)
  my_content <- gsub(emojis['grinning2'], ' grinning ', my_content)
  my_content <- gsub(emojis['tears_of_joy2'], ' joy ', my_content)
  my_content <- gsub(emojis['smiling6'], ' smiling ', my_content)
  my_content <- gsub(emojis['smiling_heart2'], ' smiling ', my_content)
  my_content <- gsub(emojis['smiling_wry'], ' wry smile ', my_content)
  my_content <- gsub(emojis['kiss3'], ' kiss ', my_content)
  my_content <- gsub(emojis['pouting2'], ' pouting ', my_content)
  my_content <- gsub(emojis['crying2'], ' crying ', my_content)
  my_content <- gsub(emojis['weary2'], ' weary ', my_content)
  my_content <- gsub(emojis['no_good'], ' no good ', my_content)
  my_content <- gsub(emojis['okay'], ' okay ', my_content)
  my_content <- gsub(emojis['bowing'], ' bowing ', my_content)
  my_content <- gsub(emojis['see_no_evil'], ' see no evil ', my_content)
  my_content <- gsub(emojis['hear_no_evil'], ' hear no evil ', my_content)
  my_content <- gsub(emojis['say_no_evil'], ' say no evil ', my_content)
  my_content <- gsub(emojis['happy'], ' happy ', my_content)
  my_content <- gsub(emojis['frowning'], ' frowning ', my_content)
  my_content <- gsub(emojis['pouting3'], ' pouting ', my_content)
  my_content <- gsub(emojis['praying'], ' prayers ', my_content)
 
  return(my_content) 
}