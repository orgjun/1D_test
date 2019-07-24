  output$T_table <- renderTable({
    inFile <- input$T_file
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)
  })
  
  T_compute <- function(){
    sink("result.txt")
    inFile <- input$T_file
    tbl <- read.csv(inFile$datapath, header = F)
    a <- as.matrix(tbl)
    b <- t(a)
    c <- as.vector(b)
    score <- c[!is.na(c)]
    group <- factor(rep(c(paste("group_", (1:nrow(tbl)), sep="")),c(apply(!is.na(tbl),1,sum))))
    t <- TukeyHSD(aov(score ~ group))
      
    print(t)
    sink()
    return(t)
  }
  
  output$T_results<-renderPrint({
    inFile <- input$T_file
    if (is.null(inFile))
      return("No inputs")
    T_compute()
  })
  
  
  output$T_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
