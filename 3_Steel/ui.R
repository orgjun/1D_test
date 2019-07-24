library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",

    #panel 3 Steel
    tabPanel("Steel",
             titlePanel("Steel-Dwassの検定"),
             source("3S_ui.R", local=TRUE,encoding = "utf-8")$value)
  )

)

