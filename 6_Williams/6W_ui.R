  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("W_obs","add"),
                 
                 uiOutput("W_selectInputs"),
                 actionButton("W_clear","clear")
                 
        ),
        
        tabPanel("アップロードCSVファイル",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),
                 
                 fileInput('W_file', 'CSVファイルを指定してください',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                 actionButton("W_clear_2","clear")
                 
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