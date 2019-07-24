  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel("Manual input",
                 p(br()),
                 helpText("Missing value is input as NA"),
                 
                 ## disable on chrome
                 actionButton("SW_obs","add"),
                 
                 uiOutput("SW_selectInputs")
                 
        ),
        
        tabPanel("CSV",
                 helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。
               また、サンプルサイズはそろえるようにしてください。"),
                 
                 fileInput('SW_file', 'Choose CSV File',
                           accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
                 
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
  
  