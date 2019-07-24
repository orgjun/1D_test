#new
output$SW_selectInputs <- renderUI({
  w <- ""
  
  if(input$SW_obs!=0){
    isolate({
      w <- paste(w, textInput("SW_y", "group_1", 
                              value = input[[sprintf("SW_y",0)]]))
      for(i in 1:(input$SW_obs)) {
        w <- paste(w, textInput(paste0("SW_x", i, sep = ""), paste0("group_", i+1, sep = ""), 
                                value = input[[sprintf("SW_x%d",i)]])) ## or value = "4 \n5 \n 6"
      }
      
      HTML(w)
    })
    
  }else{ 
    w <- paste(w, textInput("SW_y", "group_1", 
                            value = "")) ## or value = "1 \n2 \n 3"
    HTML(w)
  }
  
})

#new
SW_X<-reactive({
  
  inFile<-input$SW_file
  
  
  if (is.null(inFile)){#file or data
    
    if(input$SW_obs!=0)#X and Y are definded
    {
      y_both <- str_trim(input$SW_y, side = "both")
      Y <- as.numeric(unlist(strsplit(y_both,  split="[\n, \t, ]+")))
      Y <- data.frame(Y=Y)
      Ylengthnum<-nrow(Y)#number=nrow NULL=0
      
      truel <- input$SW_obs
      X <- vector("list", truel)
      
      nobs <- c(1:truel) ## total number of x
      col <- paste0("SW_x", nobs) ## create a list of x name, x1 x2 x3...
      
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

#change
output$SW_table <- renderTable({SW_X()})
  
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
  
  
 #change 
  SW_compute <- function(){
    if(is.data.frame(SW_X())){
      sink("result.txt")
      tbl <- SW_X()
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
  }
  
  
  
  output$SW_results<-renderPrint({
    if (is.data.frame(SW_X()))
    {tryCatch({SW_compute()},
              error = function(e){HTML("Error in your data!")})}
    else{return("No outputs!")}
  })
  
  
  output$SW_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
  

