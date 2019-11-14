library(shiny)
library(dplyr)
library(ggplot2)

#1 FV
#' @title future value
#' @description calculates the future value
#' @param a numeric integer for present value amount
#' @param r numeric annual rate of return 
#' @param y numeric time in years
#' @return computed future value
future_value <- function(a, r, y) {
    return(a * ((1 + r) ^ y))
}

#2 FVA
#' @title annuity
#' @description calculates the annuity
#' @param c numeric contribution (how much you deposit at the end of the year)
#' @param r numeric annual rate of return 
#' @param y numeric time in years
#' @return computed annuity
annuity <- function(c, r, y) {
    return( c * (((1 + r)^y - 1) / r))
}

#3 FVGA
#' @title future value of growing annuity
#' @description calculates the future value of growing annuity
#' @param c numeric first contribution
#' @param r numeric annual rate of return 
#' @param g numeric growth rate
#' @param y numeric time in years
#' @return computed future value of growing annuity
growing_annuity <- function(c, r, g, y) {
    return(c *(((1 + r) ^y - (1 + g)^y) / (r - g)))
}


# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Title of your app: workout02.shiny app"),
    
    fluidRow(
        column(3, sliderInput(inputId = "init_a",
                              label = "Initial Amount",
                              min = 1,
                              max = 10000,
                              value = 1000,
                              step = 500,
                              pre = "$")),
        column(3, sliderInput(inputId = "high_y_a",
                              label = "High Yield annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 2)),
        column(3, sliderInput(inputId = "high_y_v",
                              label = "High Yield volatility (in %)",
                              min = 0,
                              max = 20,
                              value = 0.1)),
        column(3, sliderInput(inputId = "years",
                              label = "Years",
                              min = 0,
                              max = 50,
                              value = 10))
    ),
    fluidRow(
        column(3, sliderInput(inputId = "annual_c",
                              label = "Annual Contribution",
                              min = 0,
                              max = 5000,
                              value = 200,
                              step = 500,
                              pre = "$")),
        column(3, sliderInput(inputId = "fixed_i_a",
                              label = "Fixed Income annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 5)),
        column(3, sliderInput(inputId = "fixed_i_v",
                              label = "Fixed Income volatility (in %)",
                              min = 0,
                              max = 20,
                              value = 4.5)),
        column(3, numericInput(inputId = "num", 
                               label = h3("Random seed"), 
                               value = 12345))
    ),
    fluidRow(
        column(3, sliderInput(inputId = "annual_g",
                              label = "Annual Growth Rate (in %)",
                              min = 0,
                              max = 20,
                              value = 3)),
        column(3, sliderInput(inputId = "us_a",
                              label = "US Equity annual rate (in %)",
                              min = 0,
                              max = 20,
                              value = 10)),
        column(3, sliderInput(inputId = "us_v",
                              label = "US Equity volatility Rate (in %)",
                              min = 0,
                              max = 20,
                              value = 15)),
        column(3, selectInput("facet", 
                              "Facet?",
                              choice = c("No", "Yes")))
    ),



        # Show a line of the generated distribution
    mainPanel(
        hr(),
        h4("Timelines"),
        width = 12, 
        plotOutput("distPlot"),
        h4("Balances"),
        verbatimTextOutput("summary")
    )
)


# Define server logic required to draw a timeline
server <- function(input, output) {
    df1 <- reactive({
        
        # Modalities
        fv <- c()
        fva <- c()
        fvga <- c()
        for (i in 0:input$year) {
            fv0 <- future_value(input$init_a,input$r_rate * 0.01,  i)
            fva0 <- fv0 + annuity( input$annual_cont, input$r_rate * 0.01,  i)
            fvga0 <- fv0 + growing_annuity(input$annual_cont, input$r_rate * 0.01, input$g_rate * 0.01, i)
            fv <- append(fv, fv0)
            fva <- append(fva, fva0)
            fvga <- append(fvga, fvga0)
        }
        modalities <- data.frame(
            year = 0:input$year,
            no_contrib = fv,
            fixed_contrib = fva,
            growing_contrib = fvga
        )
        return(modalities)
    })
    
    output$distPlot <- renderPlot ({
        label <- c("no_contrib", "fixed_contrib", "growing_contrib")
        x <- factor(1:3, labels = label)
        year = df1()$year
        
        df2 <- data.frame(
            year = rep(year, 3),
            balance = c(df1()$no_contrib, df1()$fixed_contrib, df1()$growing_contrib),
            variable = rep(x, each = length(year)),
            levels = label
        )
        
        if (input$facet == "No") {
            ggplot(data = df2, aes(x = year, y = balance, group = variable)) +
                geom_point(aes(color = variable)) + geom_path(aes(color = variable)) +
                xlab("Year") +
                ylab("Value") +
                ggtitle("Three modes of investing")
        } else {
            ggplot(data = df2, aes(x = year, y = balance, group = variable)) +
                geom_point(aes(color = variable)) + geom_path(aes(color = variable)) + geom_area(aes(fill = variable), alpha = 0.4) +
                xlab("Year") +
                ylab("Value") +
                ggtitle("Three modes of investing") +
                facet_grid(~ variable) + 
                theme_bw()
        }
    })
    output$summary <- renderPrint({
        df1()
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
