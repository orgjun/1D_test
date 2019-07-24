library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",
    
    #panel 6 Williams
    tabPanel("Williams",
             titlePanel("Williams"),
             source("6W_ui.R", local=TRUE,encoding = "utf-8")$value)  
  )

)

