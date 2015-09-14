require(markdown)
        
shinyUI(fluidPage(
    navbarPage("Exploratory Linear Modelling on the ‘mtcars’ Dataset"),
    fluidRow(
        column(4,
               includeMarkdown("documentation1.md"),
               hr(),
               uiOutput("colNamesDropdown1"),
               uiOutput("colNamesDropdown2"),
               sliderInput("size", "Display Size:", min = 1, max = 10, value = 5),
               hr(),
               includeMarkdown("documentation2.md")
        ),
        column(7,
               plotOutput("plot"),
               hr(),
               actionButton("btnSubmit", "Show Linear Model Detail"),
               br(),br(),
               textOutput("modelSummaryText"),
               br(),
               verbatimTextOutput("modelSummaryPrint"),
               plotOutput("modelPlot")
        )
    )
))