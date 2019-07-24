  output$SW_table <- renderTable({
    
    inFile <- input$SW_file
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)
  })
  
  Shirley.Williams <- function( data,  group,   method=c("up", "down")){
    OK <- complete.cases(data, group)                   
    data <- data[OK]
    group <- group[OK]
    method <- match.arg(method)                          
    func <- if (method == "down") min else max           
    ni <- table(group)                                   
    a <- length(ni)                                              
    s <- numeric(a-1)
    for (p in a:2) {
      select <- 1 <= group & group <= p           
      r <- rank(data[select])                             
      g <- group[select]                           
      M <- func(cumsum(rev(tapply(r, g, sum))[-p])/cumsum(rev(ni[2:p])))
      N <- sum(ni[1:p])
      V <- (sum(r^2)-N*(N+1)^2/4)/(N-1)
      t <- (M-sum(r[group == 1])/ni[1])/sqrt(V*(1/ni[p]+1/ni[1]))
      s[p-1] <- ifelse(method == "down", -t, t)
    }
    t <- rev(s)
    names(t) <- a:2
    return(t)
  }
  
  
  
  SW_compute <- function(){
    sink("result.txt")
    inFile <- input$SW_file
    tbl <- read.csv(inFile$datapath, header = F)
    a <- as.matrix(tbl)
    b <- t(a)
    c <- as.vector(b)
    data <- c[!is.na(c)]
    group <- rep(1:nrow(a),c(apply(!is.na(tbl),1,sum)))
    t <- Shirley.Williams(data, group, method = "up")
    
    print(t)
    sink()
    return(t)
  }
  
  
  output$SW_results<-renderPrint({
    
    inFile <- input$SW_file
    if (is.null(inFile))
      return("No inputs")
    SW_compute()
  })
  
  
  output$SW_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
