#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(tidyverse)
library(readr)
library(ggplot2)
library(readr)
library(dplyr)
library(plotly)
data <- read.csv("TaylorSwift13.csv")
data$date_wtime = as.Date(str_sub(data$date, 1, 10))

##  Trends & Activity 


#slider bar range that can move, 
library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Taylor Swift's Twitter Activity"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("date_range", "Select Date Range", 
                  min = min(data$date_wtime), max = max(data$date_wtime),
                  value = c(min(data$date_wtime), max(data$date_wtime)),
                  step = 1)
    ),
    mainPanel(
      plotOutput("tweet_plot")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    data %>%
      filter(date_wtime >= input$date_range[1] & date_wtime <= input$date_range[2]) %>%
      group_by(date_wtime) %>%
      summarise(content = n())
  })
  
  output$tweet_plot <- renderPlot({
    filtered_data() %>%
      ggplot(aes(x = date_wtime, y = content, color = content, size = content)) +
      geom_point() +
      scale_color_gradient(low = "lightblue", high = "blue") +
      labs(title = "Taylor Swift's Twitter Activity Over Time",
           x = "Date",
           y = "Number of Tweets")
  })
}

shinyApp(ui = ui, server = server)


## Outreach & Influence



