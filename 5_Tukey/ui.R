library(shiny)
if(!require("stringr")) install.packages("stringr")
library("stringr")

shinyUI(navbarPage(
    "Multiple comparison test",

    #panel 5 Tukey
    tabPanel("Tukey",
             titlePanel("TukeyのHSD検定"),
             source("5T_ui.R", local=TRUE,encoding = "utf-8")$value)
  )

)

