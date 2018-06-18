ui <- fluidPage(
  
  # App title ----
  titlePanel("Visualizing The Relationship between JAP Article Keywords"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      numericInput("obs",NULL,2018, min = 1917, max = 2018),
      
      # adding the new div tag to the sidebar            
      tags$div(class="header", checked=NA,
               tags$p("The following web application visualizes the relationship (specifically co-occurrence) between keywords linked to every article released by the Journal of Applied Psychology since 1917. Click, drag, and zoom in on the nodes to interact with the network."),
               tags$p("Note: If a number that isn't between 1917 and 2018 is entered, an error will occur."),
               tags$a(href="https://github.com/BListyg/JAP-Abstracts", "Click here for full dataset."),
               tags$p(""),
               tags$a(href="https://twitter.com/benlistyg", "You can follow me on twitter @BenListyg")
      )
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      visNetworkOutput("network",width = '100%',height = '600px')
      
    )
  )
)