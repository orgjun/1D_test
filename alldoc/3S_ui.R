  sidebarLayout(
    sidebarPanel(
      helpText("データが入っているファイルを選んでください。
               ただし、データの形式は一行目が対照群(コントロール群)、二行目以降が処理群となるようにしてください。"),
      fileInput('S_file', 'Choose CSV File',
                accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')
      )
      ),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('S_table'),
      h4('Results:'),
      verbatimTextOutput("S_results"),
      h4('Download:'),
      downloadButton('S_downloadData', 'Download')
    )
)
