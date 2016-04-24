
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rvest)
library(xml2)
library(dplyr)
library(DT)

shinyServer(function(input, output) {
  
 # url <- "https://www.tripadvisor.in/Hotel_Review-g303890-d5614919-Reviews-Altius_Nest-Kodaikanal_Tamil_Nadu.html"
  observeEvent(input$action, {
    
    url <- input$url
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
    
    reviewdf <- data_frame(id,quote,rating,ratingdate,review) 
    
    
    output$reviewtable <- renderDataTable({
      
      datatable(reviewdf)
      
    })
    
    
  })
  
  
  
})
