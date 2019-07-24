  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("SW_obs","add"),
                 
                 uiOutput("SW_selectInputs"),
                 actionButton("SW_clear","clear")
                 
        ),        tabPanel("アップロードCSVファイル",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。
               また、サンプルサイズはそろえるようにしてください。"),
                 
                 fileInput('SW_file', 'CSVファイルを指定してください',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                 actionButton("SW_clear_2","clear")
                 
        )
      )),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('SW_table'),
      h4('Results:'),
      verbatimTextOutput("SW_results"),
      h4('Download:'),
      downloadButton('SW_downloadData', 'Download')
    )
  )
  
  