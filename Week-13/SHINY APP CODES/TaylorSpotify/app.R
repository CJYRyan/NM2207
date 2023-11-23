
# Load required libraries
library(tidyverse)
library(ggplot2)
library(corrplot)
#load dataset
data <- read.csv("TaylorSwiftSpotify.csv")

# app.R
# Define UI for Shiny app
ui <- fluidPage(
  titlePanel("Scatter Plot and Correlation Visualization"),
  mainPanel(
    plotOutput("scatterPlot"),
    br(),
    verbatimTextOutput("correlationOutput"),
    br(),
    plotOutput("corrplot")
  )
)

# Define server logic for Shiny app
server <- function(input, output) {
  # Scatter plot
  output$scatterPlot <- renderPlot({
    ggplot(data, aes(x = energy, y = valence)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "blue") +
      labs(title = "Energy vs. Valence",
           x = "energy",
           y = "valence") +
      theme_minimal()
  })
  
  # Correlation output
  output$correlationOutput <- renderText({
    correlation <- cor(data$energy, data$valence)
    paste("Correlation between Energy and Valence:", correlation)
  })
  
  # Corrplot
  output$corrplot <- renderPlot({
    corrplot(cor(data[, c("energy", "valence")]), method = "circle", type = "full")
  })
}

# Run the Shiny app
shinyApp(ui, server)