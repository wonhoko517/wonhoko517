library(shiny)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Title of your app: workout02.shiny app"),
    
    fluidRow(
        column(3, sliderInput(inputId = "num",
                              label = "Initial Amount",
                              min = 1,
                              max = 10000,
                              value = 1000)),
        column(3, sliderInput(inputId = "num",
                              label = "High Yield annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 2)),
        column(3, sliderInput(inputId = "num",
                              label = "High Yield volatility (in %)",
                              min = 0,
                              max = 20,
                              value = 0.1)),
        column(3, sliderInput(inputId = "num",
                              label = "Years",
                              min = 0,
                              max = 50,
                              value = 10))
    ),
    fluidRow(
        column(3, sliderInput(inputId = "num",
                              label = "Annual Contribution",
                              min = 0,
                              max = 5000,
                              value = 200)),
        column(3, sliderInput(inputId = "num",
                              label = "Fixed Income annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 5)),
        column(3, sliderInput(inputId = "num",
                              label = "Fixed Income volatility (in %)",
                              min = 0,
                              max = 20,
                              value = 4.5)),
        column(3, numericInput(inputId = "num", 
                               label = h3("Random seed"), 
                               value = 12345))
    ),
    fluidRow(
        column(3, sliderInput(inputId = "num",
                              label = "Annual Growth Rate (in %)",
                              min = 0,
                              max = 20,
                              value = 3)),
        column(3, sliderInput(inputId = "num",
                              label = "US Equity annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 10)),
        column(3, sliderInput(inputId = "num",
                              label = "US Equity volatility Rate (in %)",
                              min = 0,
                              max = 20,
                              value = 15)),
        column(3, selectInput('facet',
                              'Facet', 
                              c(Yes = '.', No = '.'), 
                              selected = "No"))
    ),



        # Show a line of the generated distribution
        mainPanel(
           plotOutput("line")
    )
)


# Define server logic required to draw a timeline
server <- function(input, output) {
    data <- reactive({
        rnorm(input$num)
    })
    output$line <- renderPlot({
        line(rnorm(input$num))
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
