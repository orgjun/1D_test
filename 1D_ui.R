sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Manual input",
                 p(br()),
                 helpText("Missing value is input as NA"),
                # numericInput("obs", "Number of observations to view:",3,min = 1,max = 10),
                  
                # tags$textarea(id = "x1",rows = 10,"4.2\n5.3\n7.6\n6.7\n6.3\n3.5\n5.8\n6.3\n3.2\n4.6\n5.5\n5.2\n4.6\n4.8\n4.5\n5.3\n4.3\n4.3\n6.2\n6.7"),
                 ## disable on chrome
                 actionButton("obs","add"),
                 #tags$textarea(id = paste("x",input$obs),rows = 10,"4.2\n5.3\n7.6\n6.7\n6.3\n3.5\n5.8\n6.3\n3.2\n4.6\n5.5\n5.2\n4.6\n4.8\n4.5\n5.3\n4.3\n4.3\n6.2\n6.7"),
                 htmlOutput("selectInputs"), 
                 actionButton("update","Update"),
                
                 helpText("Change the names of samples (optinal)"),
                 tags$textarea(id = "cn2", rows = 2, "X\nY")
        )
      ,
      
      tabPanel("Csv",
               helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),
               fileInput('D_file', 'Choose CSV File',
                accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
      
      )
    )),
    mainPanel(

      h4('Input Confirm:'),
      tableOutput('D_table'),
      h4('Results:'),
      verbatimTextOutput("D_results"),
      h4('Download:'),
      downloadButton('D_downloadData', 'Download')
    )
  )

