  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("T_obs","add"),
                 
                 uiOutput("T_selectInputs"),
                 actionButton("T_clear","clear")
                 
        ),
        
        tabPanel("アップロードCSVファイル",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は行数がグループ数になるようにしてください。"),
                 
                 fileInput('T_file', 'CSVファイルを指定してください',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                 actionButton("T_clear_2","clear")
                 
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
  
  