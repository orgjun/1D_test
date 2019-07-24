  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("S_obs","add"),
                 
                 uiOutput("S_selectInputs"),
                 actionButton("S_clear","clear")
                 
        ),
        
        tabPanel("アップロードCSVファイル",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),
                 
                 fileInput('S_file', 'CSVファイルを指定してください',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                 actionButton("S_clear_2","clear")
                 
        )
      )),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('S_table'),
      h4('Results:'),
      verbatimTextOutput("S_results"),
      h4('Download:'),
      downloadButton('S_downloadData', 'Download')
    )
  )
  
  