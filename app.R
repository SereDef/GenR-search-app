# Hi, this is a quick set up for the application interface to search in GenR
# This is still very much work in progress so please if you have any suggestions 
# or you want to help shoot me an email at s.defina@erasmusmc.nl

# import the libraries we are going to need
library(shiny)
library(shinyWidgets)
library(shinyTree)

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
  
  titlePanel(h1("Generation R Search Engine", # Add title panel
                style='font-family:verdana; font-weight: bold; font-size:30pt;
                color:#0C3690; background-color:#B6CCE7;
                padding: 10px 20px 10px 30px;')), 
  
  sidebarLayout( # Define a sidebar panel and a main panel layout 
                 # with input and output definitions respectively 
                 # note: optional argument position = "right"to move the sidebar 
    
    # Main panel for displaying inputs -----------------------------------------
    sidebarPanel( 
      
      p("Hello friend, welcome to the beautiful universe of Generation R data. 
        Looking for something in particular? Here are some searching filters you may find useful:"),
      br(),
      
      h4('Who / what are you interested in?'),
      shinyTree("tree", theme = 'proton', themeIcons = F, checkbox = TRUE),
      
      br(),
      
      h4('When / in what time range?'),
      shinyWidgets::sliderTextInput( # Specify the age range within which to search for data 
        inputId = "timerange", label = "Note: i.e. child age in years", 
        choices = years, selected = c("Prenatal", "17y"), 
        grid = TRUE),
      
      br(),
      
      h4('What are you searching for?'),
      textInput(inputId = "keyword", # this takes input text to feed the search. 
                label = "Type in some keywords. Separate them with a ; ",
                value = ""),
    
    ),
    
    # Main panel for displaying outputs ----------------------------------------
    mainPanel(
      tabsetPanel(
        tabPanel("Overview", 
                 
                 # h4(textOutput("selected_data_type")),
                 # h4(textOutput("selected_subjects")),
                 # h4(textOutput("min_max")),
                 
                 br(), 
                 
                 tableOutput("view"),
                 
                 a("https://generationr.nl/"), # Hyperlink to generation R website
                 img(src = "generation-r-logo.png", height = 140, 
                     style="display: block; margin-left: auto; margin-right: 0;") 
                 ),
        
        tabPanel("Data dictionary") 
                 #h4("This one is still in progress, hold tight")),
      )
    )
  )
)


################################################################################
# ------------------ Define server logic to view selected dataset  -------------
################################################################################

server <- function(input, output) {
  
  output$tree <- renderTree({ list(
    'Children'= list('Questionnaires'   =  structure(list('Self reports'= 11, 
                                                          'Main caregiver reports'= 12, 
                                                          'Teacher reports'= 13), stselected=TRUE),
                     'Measurements'   =  structure(list('Cognitive tasks'= 14, 
                                                        'Morphology'= 15)), 
                     'Biological samples'   =  structure(list('Neuroimaging'= 16, 
                                                              'Genetics'= 17))),
    'Mothers'= list('Questionnaires' =  21,
                    'Measurements' = structure(list('Cognitive tasks'= 22, 
                                                    'Morphology'= 23)), 
                    'Biological samples'   =  structure(list('Neuroimaging'= 24, 
                                                             'Genetics'= 25))), 
    'Partners'= list('Questionnaires' =  31,
                     'Measurements'   = 32, 
                     'Biological samples'  =  structure(list('Neuroimaging'=34, 
                                                             'Genetics'=35)))) 
  })
  
  # output$selected_data_type <- renderText({ 
  #   paste("You have selected", ifelse(input$datatype == 1, "questionnaires", "brain data"), 
  #   "about", ifelse(input$subjects == 1, "children", "mothers"), "ranging from",
  #         input$timerange[1], "to", input$timerange[2])})
  
  output$view <- renderTable({
    searchselection(t = qsum, subj = names(as.data.frame(get_selected(input$tree, format = "names"))), 
                    timeframe = c(input$timerange[1], input$timerange[2]), keyword = input$keyword)
  })
}
    
################################################################################
# --------------------------- MAKE IT ALIVE & SHINY  ---------------------------
################################################################################

shinyApp(ui = ui, server = server)

