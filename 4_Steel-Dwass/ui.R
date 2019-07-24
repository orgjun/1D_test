library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",

    #panel 4 Steel-Dwass
    tabPanel("Steel-Dwass",
             titlePanel("Steel-Dwassの検定"),
             source("4SD_ui.R", local=TRUE,encoding = "utf-8")$value)
  )

)

