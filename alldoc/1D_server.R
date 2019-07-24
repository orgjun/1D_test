  output$D_table <- renderTable({
    
    inFile <- input$D_file
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)
  })
  
  D_compute <- function(){
    sink("result.txt")
    inFile <- input$D_file
    tbl <- read.csv(inFile$datapath, header = F)
    a <- as.matrix(tbl)
    b <- t(a)
    c <- as.vector(b)
    score <- c[!is.na(c)]
    group <- factor(rep(c(paste("group_", (1:nrow(tbl)), sep="")),c(apply(!is.na(tbl),1,sum))))
    t <- summary(glht(aov(score ~ group), linfct=mcp(group="Dunnett")))
    
    print(t)
    sink()
    return(t)
  }
  
  
  output$D_results<-renderPrint({
    
    inFile <- input$D_file
    if (is.null(inFile))
      return("No inputs")
    D_compute()
  })
  
  
  output$D_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
