library(shiny)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Title of your app: workout02.shiny app"),

    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "num",
                        label = "Initial Amount",
                        min = 1,
                        max = 10000,
                        value = 1000),
            sliderInput(inputId = "num",
                        label = "High Yield annual rate (in %)",
                        min = 0,
                        max = 20,
                        value = 2),
            sliderInput(inputId = "num",
                        label = "High Yield volatility (in %)",
                        min = 0,
                        max = 20,
                        value = 0.1),
            sliderInput(inputId = "num",
                        label = "Years",
                        min = 0,
                        max = 50,
                        value = 10),
            sliderInput(inputId = "num",
                        label = "Annual Contribution",
                        min = 0,
                        max = 5000,
                        value = 200),
            sliderInput(inputId = "num",
                        label = "Fixed Income annual rate (in %)",
                        min = 0,
                        max = 20,
                        value = 5),
            sliderInput(inputId = "num",
                        label = "Fixed Income volatility (in %)",
                        min = 0,
                        max = 20,
                        value = 4.5),
            sliderInput(inputId = "num",
                        label = "Annual Growth Rate (in %)",
                        min = 0,
                        max = 20,
                        value = 3),
            sliderInput(inputId = "num",
                        label = "US Equity annual rate (in %)",
                        min = 0,
                        max = 20,
                        value = 10),
            sliderInput(inputId = "num",
                        label = "US Equity volatility Rate (in %)",
                        min = 0,
                        max = 20,
                        value = 15),
            numericInput(inputId = "num", 
                         label = h3("Numeric input"), 
                         value = 1),
            selectInput('facet',
                        'Facet', 
                        c(Yes = '.', No = '.'), 
                        selected = "No")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("hist")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    set.seed(12345)
    # mean = rate_bonds
    # sd = vol_bonds
    trace_0 <- rnorm(1, mean = 0.02, sd = 0.001)
    trace_1 <- rnorm(1, mean = 0.05, sd = 0.045)
    trace_2 <- rnorm(1, mean = 0.1, sd = 0.15)
    x <- c(0:1)
    data <- data.frame(x, trace_0, trace_1, trace_2)
    p <- plot_ly(data, x = ~x)
        add_trace(y = ~trace_0, name = 'trace 0',mode = 'lines')
        add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines')
        add_trace(y = ~trace_2, name = 'trace 2', mode = 'lines')
# if at least one facet column/row is specified, add it
facets <- paste(input$facet_row, '~', input$facet_col)
if (facets != '. ~ .') p <- p + facet_grid(facets)
}

# Run the application 
shinyApp(ui = ui, server = server)
