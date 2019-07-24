#new
output$S_selectInputs <- renderUI({
  w <- ""
  
  if(input$S_obs!=0){
    isolate({
      w <- paste(w, textInput("S_y", "group_1", 
                              value = input[[sprintf("S_y",0)]]))
      for(i in 1:(input$S_obs)) {
        w <- paste(w, textInput(paste0("S_x", i, sep = ""), paste0("group_", i+1, sep = ""), 
                                value = input[[sprintf("S_x%d",i)]])) ## or value = "4 \n5 \n 6"
      }
      
      HTML(w)
    })
    
  }else{ 
    w <- paste(w, textInput("S_y", "group_1", 
                            value = "")) ## or value = "1 \n2 \n 3"
    HTML(w)
  }
  
})

#new
S_X<-reactive({
  
  inFile<-input$S_file
  
  
  if (is.null(inFile)){#file or data
    
    if(input$S_obs!=0)#X and Y are definded
    {
      y_both <- str_trim(input$S_y, side = "both")
      Y <- as.numeric(unlist(strsplit(y_both,  split="[\n, \t, ]+")))
      Y <- data.frame(Y=Y)
      Ylengthnum<-nrow(Y)#number=nrow NULL=0
      
      truel <- input$S_obs
      X <- vector("list", truel)
      
      nobs <- c(1:truel) ## total number of x
      col <- paste0("S_x", nobs) ## create a list of x name, x1 x2 x3...
      
      Xlength<-c()#vector
      
      for (i in nobs){
        x_both <- str_trim(input[[as.character(col[i])]], side = "both")
        X[[i]] <- as.numeric(unlist(strsplit(
          x_both,  ## input$x1, input$x2...
          split="[\n, \t, ]+")))
        Xlength[i]<-length(X[[i]])
      }
      
      TFlogic<-all(Xlength==Ylengthnum)#判断整个X的长度相同
      if(TFlogic){
        X <- as.data.frame(X)
        
        if(nrow(Y)!=0){
          xlist <-cbind.data.frame(Y,X)
          
          X<-t(as.matrix(xlist))
          X<-data.frame(X)
          return(X)
          
        }else{return("wrong 3: Please put in all of your data.")}
        
      }else{return("wrong 2: Please put data in the same length.")}
      
    }else{return("wrong 1: Please put in your data.")}
    
  }else{
    tbl <- read.csv(
      inFile$datapath,
      header = F)
    return(tbl)
  }
})

 
 output$S_table <- renderTable({S_X()})
  
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
    if(is.data.frame(S_X())){
      sink("result.txt")
      tbl <- S_X()
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

  }
  

  output$S_results<-renderPrint({
    if (is.data.frame(S_X()))
    {tryCatch({S_compute()},
              error = function(e){HTML("Error in your data!")})}
    else{return("No outputs!")}
  })
  
  output$S_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
