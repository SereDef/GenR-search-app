
library(shiny)
library(shinyTree)
library(shinyWidgets)

# point to the script the does the search 
source("search.R")
# point to the dataframe with all data 
qsum <- readRDS("data/qrep.rds")


# define some options for slider 
years = c("Prenatal", "2.6m", "1y", "1.5y", "2y", "3y", "4y", "6y", "8y", "10y", "13y", "17y")

ui <- fluidPage(

  titlePanel("Generation R Search Engine"), # Add title panel

  sidebarLayout( # Define a sidebar panel and a main panel layout
    # with input and output definitions respectively
    # note: optional argument position = "right"to move the sidebar

    # Main panel for displaying inputs -----------------------------------------
    sidebarPanel(

      p("Welcome friend, here are some searching filters you may need:"),

      h4('Who are you interested in?'),
      shinyTree("tree", theme = 'proton', themeIcons = F, checkbox = TRUE),
      
      br(),

      shinyWidgets::sliderTextInput( # Specify the age range within which to search for data
        inputId = "timerange", label = "Time Range (child age in years):", 
        choices = years, selected = c("Prenatal", "17y"), grid = TRUE
        ),

      textInput(inputId = "keyword", # this takes input text to feed the search. 
                label = "What are you searching for?",
                value = "")
    ),

   # Main panel for displaying outputs ----------------------------------------
  mainPanel(
    tabsetPanel(
      tabPanel("Overview",

               h4(textOutput("selected_data_type")),
               h4(textOutput("selected_subjects")),
               h4(textOutput("min_max")),

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
    'Partners'= list('Questionnaires' =  '31',
                     'Measurements'   = '32', 
                     'Biological samples'  =  structure(list('Neuroimaging'='34', 
                                                             'Genetics'='35')))) 
  })
  
  output$selected_data_type <- renderPrint({
    paste(names(as.data.frame(get_selected(input$tree, format = "names"))), 
           length(names(as.data.frame(get_selected(input$tree, format = "names")))))
    # names(as.data.frame(get_selected(input$tree$Children, format = "slices"))))
  
  # output$selected_data_type <- verbatimTextOutput({
  #   text <- textoutput(m = get_selected(input$tree),
  #              p = get_selected(input$tree$Partners),
  #              c = get_selected(input$tree$Children))
  #   text
    })
  # output$selected_data_type <- renderText({ 
  #   paste("OK:", textoutput(m = (get_selected(input$tree$Mothers)),
  #              p = (get_selected(input$tree$Partners)),
  #              c = (get_selected(input$tree$Children))))

          
          # ifelse(input$tree == '1', "Children", "brain data"),
          # "about", ifelse(input$tree == '3', "children", "mothers"), "ranging from",
          # input$timerange[1], "to", input$timerange[2])
   # })

  output$view <- renderTable({
    searchselection(t = qsum, subj = names(as.data.frame(get_selected(input$tree, format = "names"))),
                    timeframe = c(input$timerange[1], input$timerange[2]), keyword = input$keyword)
   })
}



################################################################################
# --------------------------- MAKE IT ALIVE & SHINY  ---------------------------
################################################################################

shinyApp(ui = ui, server = server)
