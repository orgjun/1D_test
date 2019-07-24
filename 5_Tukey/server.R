library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output,session) {
    
    #panel 5 Tukey
    source("5T_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
#    observe({
#      if (input$close > 0) stopApp()                             # stop shiny
#    })
    
  }
)
