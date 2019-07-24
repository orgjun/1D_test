#new
output$SD_selectInputs <- renderUI({
  w <- ""
  
  if(input$SD_obs!=0){
    isolate({
      w <- paste(w, textInput("SD_y", "group_1", 
                              value = input[[sprintf("SD_y",0)]]))
      for(i in 1:(input$SD_obs)) {
        w <- paste(w, textInput(paste0("SD_x", i, sep = ""), paste0("group_", i+1, sep = ""), 
                                value = input[[sprintf("SD_x%d",i)]])) ## or value = "4 \n5 \n 6"
      }
      
      HTML(w)
    })
    
  }else{ 
    w <- paste(w, textInput("SD_y", "group_1", 
                            value = "")) ## or value = "1 \n2 \n 3"
    HTML(w)
  }
  
})

observeEvent(input$SD_clear,{session$reload()})
observeEvent(input$SD_clear_2,{session$reload()})

#new
SD_X<-reactive({
  
  inFile<-input$SD_file
  
  
  if (is.null(inFile)){#file or data
    
    if(input$SD_obs!=0)#X and Y are definded
    {
      y_both <- str_trim(input$SD_y, side = "both")
      Y <- as.numeric(unlist(strsplit(y_both,  split="[\n, \t, ]+")))
      Y <- data.frame(Y=Y)
      Ylengthnum<-nrow(Y)#number=nrow NULL=0
      
      truel <- input$SD_obs
      X <- vector("list", truel)
      
      nobs <- c(1:truel) ## total number of x
      col <- paste0("SD_x", nobs) ## create a list of x name, x1 x2 x3...
      
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

  output$SD_table <- renderTable({SD_X()})
  
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
    if(is.data.frame(SD_X())){
      sink("result.txt")
      tbl <- SD_X()
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

  }


  output$SD_results<-renderPrint({
    if (is.data.frame(SD_X()))
    {tryCatch({SD_compute()},
              error = function(e){HTML("Error in your data!")})}
    else{return("No outputs!")}
  })
  
  
  output$SD_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
