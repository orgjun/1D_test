 
  output$SD_table <- renderTable({
    inFile <- input$SD_file
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)
  })
  
  Steel.Dwass <- function(data,group){
    OK <- complete.cases(data, group)
    data <- data[OK]
    group <- group[OK]
    n.i <- table(group)
    ng <- length(n.i)
    t <- combn(ng, 2, function(ij) {
      i <- ij[1]
      j <- ij[2]
      r <- rank(c(data[group == i], data[group == j])) 
      R <- sum(r[1:n.i[i]])             
      N <- n.i[i]+n.i[j]           
      E <- n.i[i]*(N+1)/2                  
      V <- n.i[i]*n.i[j]/(N*(N-1))*(sum(r^2)-N*(N+1)^2/4) 
      return(abs(R-E)/sqrt(V))       
    })
    p <- ptukey(t*sqrt(2), ng, Inf, lower.tail=FALSE)
    result <- cbind(t, p)
    rownames(result) <- combn(ng, 2, paste, collapse=":")
    return(result)
  }
  
  SD_compute <- function(){
    sink("result.txt")
    inFile <- input$SD_file
    tbl <- read.csv(inFile$datapath, header = F)
    a <- as.matrix(tbl)
    b <- t(a)
    c <- as.vector(b)
    data <- c[!is.na(c)]
    group <- rep(1:nrow(a),c(apply(!is.na(tbl),1,sum)))
    t <- Steel.Dwass(data, group)
    print(t)
    sink()
    return(t)
  }
  
  output$SD_results<-renderPrint({
    inFile <- input$SD_file
    if (is.null(inFile))
      return("No inputs")
    SD_compute()
  })
  
  
  output$SD_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
