library(tidyverse)
library(shiny)
library(RColorBrewer)

data <- read.csv("TaylorSwift13.csv")

# Creating a column for date without time 
data$date_wtime = as.Date(str_sub(data$date, 1, 10))
Data_year_month <- as.Date(data$date)

data$date_year <- format(Data_year_month,"%Y")
data$date_month_numeric <- format(Data_year_month, "%m")
data$date_month <- substring(month.name[as.integer(data$date_month_numeric)], 1,3)


# Disable Scientific Notation
options(scipen = 999)

# Create table for graph
table <- data %>% group_by(date_year, date_month) %>% summarize(total_likes = sum(likeCount))
month_order <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
table$date_month <- factor(table$date_month, levels = month_order)
table_spread <- table %>% spread(key = date_month, value = total_likes)

# Choose the number of blue colors you want (12 in this case)
blue_palette <- brewer.pal(12, "Blues")

# Shiny app UI
ui <- fluidPage(
  titlePanel("Frequency of Like Counts by Year "),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Select a Year:",
                  choices = unique(table_spread$date_year),
                  selected = unique(table_spread$date_year)[1])
    ),
    mainPanel(
      plotOutput("barplot")
    )
  )
)

# Shiny app server
server <- function(input, output) {
  output$barplot <- renderPlot({
    selected_year <- input$year
    data_filtered <- subset(table_spread, date_year == selected_year)
    matrix_filtered <- as.matrix(data_filtered[, 2:ncol(data_filtered)])
    
    # Create Bar Plot
    barplot(matrix_filtered,
            col = blue_palette,  # Use the blue palette
            main = paste("Frequency of Like Counts for", selected_year),
            ylab = "Number of Like Counts",
            beside = TRUE)
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
