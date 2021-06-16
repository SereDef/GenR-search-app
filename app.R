# Hi, this is a quick set up for the application interface to search in GenR
# This is still very much work in progress so please if you have any suggestions 
# or you want to help shoot me an email at s.defina@erasmusmc.nl

# import the libraries we are going to need
library(shiny)
library(shinyWidgets)

# point to the script the does the search 
source("search.R")
# point to the dataframe with all data 
qsum <- readRDS("data/qrep.rds")

# define some options for slider 
years = c("Prenatal", "2.6m", "1y", "1.5y", "2y", "3y", "4y", "6y", "8y", "10y", "13y", "17y")

################################################################################
# ----------------------- Define UI for dataset viewer app  --------------------
################################################################################

# The function fluidPage creates a display that automatically adjusts to the 
# dimensions of user’s browser window. You lay out the user interface of the app 
# by placing elements in the fluidPage function.
  
ui <- fluidPage(
  
  titlePanel("Generation R Search Engine"), # Add title panel
  
  sidebarLayout( # Define a sidebar panel and a main panel layout 
                 # with input and output definitions respectively 
                 # note: optional argument position = "right"to move the sidebar 
    
    # Main panel for displaying inputs -----------------------------------------
    sidebarPanel( 
      
      p("Welcome friend, here are some searching filters you may need:"),
      
      checkboxGroupInput("subjects",
       # offer options to select groups of subjects
                         label = "Who are you interested in?",
                         choices = list("Children" = 1, 
                                        "Mothers" = 2, 
                                        "Partners" = 3),
                         selected = 1),
      
      checkboxGroupInput("datatype",
       # offer options to select data type
                         label = "What data type(s) are you looking for?",
                         choices = list("Questionnaires" = 1, 
                                        "Brain imaging" = 2, 
                                        "Biological samples" = 3),
                         selected = 1),
      
      shinyWidgets::sliderTextInput( # Specify the age range within which to search for data 
        inputId = "timerange", label = "Time Range (child age in years):", 
        choices = years, selected = c("Prenatal", "17y"), 
        grid = TRUE
      ),
      
      textInput(inputId = "keyword", # this takes input text to feed the search. 
                label = "What are you searching for?",
                value = ""),
      
      actionButton("update", "Search!") # to defer the rendering of output until the
        # the user explicitly clicks (rather than immediately when inputs change).
        # this will save computational time!
    ),
    
    # Main panel for displaying outputs ----------------------------------------
    mainPanel(
      
      h4(textOutput("selected_data_type")),
      h4(textOutput("selected_subjects")),
      h4(textOutput("min_max")),
      
      br(), 
      
      tableOutput("view"),
      
      a("https://generationr.nl/"), # Hyperlink to generation R website
      img(src = "generation-r-logo.png", height = 140, 
          style="display: block; margin-left: auto; margin-right: 0;")
      
    )
  )
)


################################################################################
# ------------------ Define server logic to view selected dataset  -------------
################################################################################

server <- function(input, output) {
  output$selected_data_type <- renderText({ 
    paste("You have selected", ifelse(input$datatype == 1, "questionnaires", "brain data"), 
    "about", ifelse(input$subjects == 1, "children", "mothers"), "ranging from",
          input$timerange[1], "to", input$timerange[2])})

  output$view <- renderTable({
    searchselection(t, subj = input$subjects, timeframe = input$timerange, keyword = input$keyword)
  })
}
    
################################################################################
# --------------------------- MAKE IT ALIVE & SHINY  ---------------------------
################################################################################

shinyApp(ui = ui, server = server)

