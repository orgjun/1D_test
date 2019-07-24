
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Manual input",
                 p(br()),
                 helpText("Missing value is input as NA"),
                 
                 ## disable on chrome
                 actionButton("SD_obs","add"),
                 
                 uiOutput("SD_selectInputs")
                 
        ),
        
        tabPanel("CSV",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は行数がグループ数になるようにしてください。"),
                 
                 fileInput('SD_file', 'Choose CSV File',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
                 
        )
      )),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('SD_table'),
      h4('Results:'),
      verbatimTextOutput("SD_results"),
      h4('Download:'),
      downloadButton('SD_downloadData', 'Download')
    )
  )
  
  