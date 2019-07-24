library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output,session) {
    
    #panel 6 Williams
    source("6W_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
#    observe({
#      if (input$close > 0) stopApp()                             # stop shiny
#    })
    
  }
)
