library(shiny)

shinyUI(navbarPage(
    "Multiple comparison test",

#panel 1 Dunnett
    tabPanel("Dunnett",
             titlePanel("Dunnettの検定"),
             source("1D_ui.R", local=TRUE,encoding = "utf-8")$value),

#panel 2 Shirley-Williams
    tabPanel("Shirley-Williams",
             titlePanel("Shirley-Williamsの検定"),
             source("2SW_ui.R", local=TRUE,encoding = "utf-8")$value),

#panel 3 Steel
    tabPanel("Steel",
            titlePanel("Steel-Dwassの検定"),
            source("3S_ui.R", local=TRUE,encoding = "utf-8")$value),    

#panel 4 Steel-Dwass
    tabPanel("Steel-Dwass",
             titlePanel("Steel-Dwassの検定"),
             source("4SD_ui.R", local=TRUE,encoding = "utf-8")$value),

#panel 5 Tukey
    tabPanel("Tukey",
             titlePanel("TukeyのHSD検定"),
             source("5T_ui.R", local=TRUE,encoding = "utf-8")$value),

#panel 6 Williams
    tabPanel("Williams",
             titlePanel("Williams"),
             source("6W_ui.R", local=TRUE,encoding = "utf-8")$value)    
  )
  
)
