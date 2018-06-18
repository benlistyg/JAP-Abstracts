source('Global.R', local = FALSE)

server <- function(input, output) {
  
  year_cooccur<-function(year){
    
    jap_data<-read.csv("https://github.com/BListyg/JAP-Abstracts/blob/master/JAPdata.csv?raw=true")
    #Subset matrix by year
    dat<-jap_data[which(jap_data$X4==year),]
    
    dat<-data.frame(dat$X3,dat$X1)
    
    colnames(dat) <- c("X1","X2")
    
    dat2 <- suppressMessages(melt(dat))
    w <- suppressMessages(dcast(dat2, X2~X1))
    x <- as.matrix(w[,-1])
    x[is.na(x)] <- 0
    x <- apply(x, 2,  function(x) as.numeric(x > 0))  #recode as 0/1
    v <- x %*% t(x)                                   #the magic matrix 
    diag(v) <- 0                                      #replace diagonal
    dimnames(v) <- list(w[, 1], w[,1])                #name the dimensions
    #return(v)
    return(graph_from_adjacency_matrix(v,mode = 'undirected',weighted = TRUE))
    #Paste topics together single space by article title
    #Create c matrix
  }
  
  output$network <- renderVisNetwork({
    visIgraph(year_cooccur(input$obs),type = 'full',layout = 'layout.kamada.kawai')
  })
}
