
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("SD_obs","add"),
                 
                 uiOutput("SD_selectInputs"),
                 actionButton("SD_clear","clear")
                 
        ),
        
        tabPanel("アップロードCSVファイル",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は行数がグループ数になるようにしてください。"),
                 
                 fileInput('SD_file', 'CSVファイルを指定してください',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                 actionButton("SD_clear_2","clear")
                 
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
  
  