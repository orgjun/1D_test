library(shiny)
library(multcomp)

shinyServer(
  
  function(input, output) {
    
#panel 1 Dunnett
    source("1D_server.R", local=TRUE,encoding = "utf-8")$value
    
#panel 2 Shirley-Williams
    source("2SW_server.R", local=TRUE,encoding = "utf-8")$value
    
#panel 3 Steel
    source("3S_server.R", local=TRUE,encoding = "utf-8")$value
    
#panel 4 Steel-Dwass
    source("4SD_server.R", local=TRUE,encoding = "utf-8")$value
    
#panel 5 Tukey
    source("5T_server.R", local=TRUE,encoding = "utf-8")$value
    
#panel 6 Williams
    source("6W_server.R", local=TRUE,encoding = "utf-8")$value
    
    ##########----------##########----------##########
    
 #   observe({
  #    if (input$close > 0) stopApp()                             # stop shiny
   # })
    
  }
)