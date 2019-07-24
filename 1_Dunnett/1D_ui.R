sidebarLayout(
    sidebarPanel(
      tabsetPanel(     
      tabPanel("手入力",
                 p(br()),
                 helpText("欠損値はNAと表示されます。"),
                 
                 ## disable on chrome
                 actionButton("D_obs","add"),
                 
                 uiOutput("D_selectInputs"),
               actionButton("D_clear","clear")

        ),      tabPanel("アップロードCSVファイル",
               helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),

               fileInput('D_file', 
                'CSVファイルを指定してください',
                accept=c(
                  'text/csv', 
                  'text/comma-separated-values,text/plain', 
                  '.csv')),
               actionButton("D_clear_2","clear")
      
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

