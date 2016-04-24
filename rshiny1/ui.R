
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(DT)

shinyUI(fluidPage(

  # Application title
  titlePanel(fluidRow(
    
    column(2,
           h4("Hotels Reviews")
           ),
    column(5,
           textInput("url", label = 
                       h3("Enter URL (from tripadvisor)"), 
                     value = "Enter text...")
    ),
    column(5, offset = 0,
           br(),br(),
           actionButton("action", label = "Review Summary")
    )
    
    
    )),
  hr(),

  # Sidebar with a slider input for number of bins

      dataTableOutput("reviewtable")

))
