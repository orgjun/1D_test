  output$S_table <- renderTable({
    
    inFile <- input$S_file
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)
  })
  
  Steel <- function(data, group){
    get.rho <- function(ni){
      k <- length(ni)
      rho <- outer(ni, ni, function(x, y) { sqrt(x/(x+ni[1])*y/(y+ni[1])) })
      diag(rho) <- 0
      sum(rho[-1, -1])/(k-2)/(k-1)
    }
    
    OK <- complete.cases(data, group) 
    data <- data[OK]
    group <- factor(group[OK])     
    ni <- table(group)     
    a <- length(ni)      
    control <- data[group == 1]     
    n1 <- length(control)                    
    t <- numeric(a)
    rho <- ifelse(sum(n1 == ni) == a, 0.5, get.rho(ni))  
    for (i in 2:a) {
      r <- rank(c(control, data[group == i]))     
      R <- sum(r[1:n1])                           
      N <- n1+ni[i]             
      E <- n1*(N+1)/2                     
      V <- n1*ni[i]/N/(N-1)*(sum(r^2)-N*(N+1)^2/4) 
      t[i] <- abs(R-E)/sqrt(V)                
    }
    result <- cbind(t, rho)[-1,]     
    rownames(result) <- paste(1, 2:a, sep=":")
    return(result)
  }
  
  
  S_compute <- function(){
    sink("result.txt")
    inFile <- input$S_file
    tbl <- read.csv(inFile$datapath, header = F)
    a <- as.matrix(tbl)
    b <- t(a)
    c <- as.vector(b)
    data <- c[!is.na(c)]
    group <- rep(1:nrow(a),c(apply(!is.na(tbl),1,sum)))
    t <- Steel(data, group)
    
    print(t)
    sink()
    return(t)
  }
  
  
  output$S_results<-renderPrint({
    
    inFile <- input$S_file
    if (is.null(inFile))
      return("No inputs")
    S_compute()
  })
  
  
  output$S_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
