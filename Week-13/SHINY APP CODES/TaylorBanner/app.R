library(shiny)
library(shinyjs)

# Define UI
ui <- fluidPage(
  titlePanel(""),
  tags$head(
    # Include slick library for carousel
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick-theme.css"),
    tags$script(src = "https://code.jquery.com/jquery-3.5.1.min.js"),
    tags$script(src = "https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"),
    # Additional CSS styles
    tags$style(HTML("
      .slick-carousel img {
        max-width: 100%; /* Double the maximum width to maintain aspect ratio */
        max-height: 300px; /* Set the maximum height to make it twice as big */
        margin: 5% auto; /* Center the image horizontally with a left margin */
        display: block; /* Remove any residual inline styles */
      }
      .slick-carousel {
        text-align: center; /* Center the image vertically */
      }
      .carousel-container {
        margin-left: 50%; /* Adjust the left margin as needed */
      }
    "))
  ),
  useShinyjs(),  # Enable shinyjs
  mainPanel(
    # Create a div for the carousel
    div(id = "albumCarousel", class = "slick-carousel carousel-container",
        img(src = "album20.jpg", alt = "Album 20"),
        img(src = "album21.jpg", alt = "Album 21"),
        img(src = "album22.jpg", alt = "Album 22"),
        # Add more albums as needed
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Enable slick carousel with autoplay
  shinyjs::runjs('$(".slick-carousel").slick({autoplay: true, autoplaySpeed: 1400});')
}

# Run the Shiny app
shinyApp(ui, server)
