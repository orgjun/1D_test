
  sidebarLayout(
    sidebarPanel(
      helpText("データが入っているファイルを選んでください。
               ただし、データの形式は行数がグループ数になるようにしてください。"),
      fileInput('SD_file', 'Choose CSV File',
                accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')
      )
      ),
    mainPanel(
      h4('Input Confirm:'),
      tableOutput('SD_table'),
      h4('Results:'),
      verbatimTextOutput("SD_results"),
      h4('Download:'),
      downloadButton('SD_downloadData', 'Download')
    )
)
