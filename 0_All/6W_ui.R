  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Manual input",
                 p(br()),
                 helpText("Missing value is input as NA"),
                 
                 ## disable on chrome
                 actionButton("W_obs","add"),
                 
                 uiOutput("W_selectInputs")
                 
        ),
        
        tabPanel("CSV",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),
                 
                 fileInput('W_file', 'Choose CSV File',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
                 
        )
      )),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('W_table'),
      h4('Results:'),
      verbatimTextOutput("W_results"),
      h4('Download:'),
      downloadButton('W_downloadData', 'Download')
    )
  )