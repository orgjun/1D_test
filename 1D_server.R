output$selectInputs <- renderUI({
  w <- ""
  w <- paste(w, textInput("y", "y", value = input[[sprintf("y",0)]]))
  for(i in 1:(input$obs+1)) {
      w <- paste(w, textInput(paste("x", i, sep = ""), paste("x", i, sep = ""), value = input[[sprintf("x%d",i)]]))
  }
  HTML(w)
})

X<-reactive({
  inFile<-input$D_file
  if (is.null(inFile)){
      
    if(input$obs!=0){
      Y <- as.numeric(unlist(strsplit(input$y, "[\n, \t, ]")))
      ylist <- data.frame(Y = Y)
      xlist<-data.frame(Y = Y)
 
      obsx<-paste("x",(input$obs+1))
      X <- as.numeric(unlist(strsplit(input$obsx, "[\n, \t, ]")))
      
      # xlist<-cbind(xlist,X)
      # names(xlist) = unlist(strsplit(input$cn2, "[\n, \t, ]"))
      return(x)
    
    
    
    }else{
    return(NULL)
    }
  }else{
    tbl <- read.csv(inFile$datapath,header = F)
    return(tbl)}
})



#output$selectInputs<-renderUI({
#  for (i in 0:input$obs) {
#  HTML(tags$textarea(id = paste("x",input$obs),rows = 10,"4.2\n5.3\n7.6\n6.7\n6.3\n3.5\n5.8\n6.3\n3.2\n4.6\n5.5\n5.2\n4.6\n4.8\n4.5\n5.3\n4.3\n4.3\n6.2\n6.7")
#)}
#   })

  
  output$D_table <- renderTable({X()})
  
  D_compute <- function(){
    sink("result.txt")
    tbl <- X()
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
