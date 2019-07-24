library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",

#panel 1 Dunnett
    tabPanel("Dunnett",
             titlePanel("Dunnettの検定"),
             source("1D_ui.R", local=TRUE,encoding = "utf-8")$value) 
  )

)

