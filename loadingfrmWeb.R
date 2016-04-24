library(rvest)
library(xml2)
library(dplyr)
url <- "https://www.tripadvisor.in/Hotel_Review-g303890-d5614919-Reviews-Altius_Nest-Kodaikanal_Tamil_Nadu.html"
#httr::BROWSE(url)

reviews <- url %>% read_html() %>% html_nodes("#REVIEWS .innerBubble")
#length(reviews)
#xml_structure(reviews[1])

id <- reviews  %>% html_nodes(".wrap .quote a") %>% html_attr("id")

quote <- reviews  %>% html_nodes(".quote span") %>% html_text()

rating <- reviews  %>% 
  html_nodes(".rating .rate .rating_s_fill") %>% 
  html_attr("alt") %>% 
  gsub(" of 5 stars","",.)

ratingdate <- reviews  %>% 
  html_nodes(".rating .ratingDate") %>% 
  html_attr("title") %>% 
  strptime("%d %B %Y") %>% 
  strftime("%d-%m-%Y")

review <- reviews %>% html_nodes(".entry .partial_entry") %>% html_text()

data_frame(id,quote,rating,ratingdate,review) %>% View()

