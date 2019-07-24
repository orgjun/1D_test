library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output,session) {
    
    #panel 4 Steel-Dwass
    source("4SD_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
#    observe({
#      if (input$close > 0) stopApp()                             # stop shiny
#    })
    
  }
)
