  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Manual input",
                 p(br()),
                 helpText("Missing value is input as NA"),
                 
                 ## disable on chrome
                 actionButton("T_obs","add"),
                 
                 uiOutput("T_selectInputs")
                 
        ),
        
        tabPanel("CSV",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は行数がグループ数になるようにしてください。"),
                 
                 fileInput('T_file', 'Choose CSV File',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
                 
        )
      )),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('T_table'),
      h4('Results:'),
      verbatimTextOutput("T_results"),
      h4('Download:'),
      downloadButton('T_downloadData', 'Download')
    )
  )
  
  