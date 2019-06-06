library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output) {
    
#panel 1 Dunnett
    source("1D_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
 #   observe({
  #    if (input$close > 0) stopApp()                             # stop shiny
   # })
    
  }
)