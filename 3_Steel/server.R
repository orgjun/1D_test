library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output,session) {
    
    #panel 3 Steel
    source("3S_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
#    observe({
#      if (input$close > 0) stopApp()                             # stop shiny
#    })
    
  }
)
