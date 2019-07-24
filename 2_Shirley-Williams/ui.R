library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",

    #panel 2 Shirley-Williams
    tabPanel("Shirley-Williams",
             titlePanel("Shirley-Williamsの検定"),
             source("2SW_ui.R", local=TRUE,encoding = "utf-8")$value)
  )

)

