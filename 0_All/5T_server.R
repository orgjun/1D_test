#new
output$T_selectInputs <- renderUI({
  w <- ""
  
  if(input$T_obs!=0){
    isolate({
      w <- paste(w, textInput("T_y", "group_1", 
                              value = input[[sprintf("T_y",0)]]))
      for(i in 1:(input$T_obs)) {
        w <- paste(w, textInput(paste0("T_x", i, sep = ""), paste0("group_", i+1, sep = ""), 
                                value = input[[sprintf("T_x%d",i)]])) ## or value = "4 \n5 \n 6"
      }
      
      HTML(w)
    })
    
  }else{ 
    w <- paste(w, textInput("T_y", "group_1", 
                            value = "")) ## or value = "1 \n2 \n 3"
    HTML(w)
  }
  
})

observeEvent(input$T_clear,{session$reload()})
observeEvent(input$T_clear_2,{session$reload()})

#new
T_X<-reactive({
  
  inFile<-input$T_file
  
  
  if (is.null(inFile)){#file or data
    
    if(input$T_obs!=0)#X and Y are definded
    {
      y_both <- str_trim(input$T_y, side = "both")
      Y <- as.numeric(unlist(strsplit(y_both,  split="[\n, \t, ]+")))
      Y <- data.frame(Y=Y)
      Ylengthnum<-nrow(Y)#number=nrow NULL=0
      
      truel <- input$T_obs
      X <- vector("list", truel)
      
      nobs <- c(1:truel) ## total number of x
      col <- paste0("T_x", nobs) ## create a list of x name, x1 x2 x3...
      
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

  output$T_table <- renderTable({T_X()})
  
  T_compute <- function(){
    if(is.data.frame(T_X())){
      sink("result.txt")
      tbl <- T_X()
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

  }
  
  output$T_results<-renderPrint({
    if (is.data.frame(T_X()))
    {tryCatch({T_compute()},
              error = function(e){HTML("Error in your data!")})}
    else{return("No outputs!")}
  })
  
  
  
  output$T_downloadData <- downloadHandler(
    filename = function() { 
      'result.txt' 
    },
    content = function(file) {
      file.copy("result.txt", file)
    }
  )
