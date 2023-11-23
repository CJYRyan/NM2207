library(shiny)

ui <- fluidPage(
  titlePanel("Top 3 Tweets, Click to find out more"),
  mainPanel(
    fluidRow(
      column(4,
             div(
               textOutput("info1"),
               style = "font-size: 24px; border: 2px solid black; padding: 15px; position: relative; height: 250px; vertical-align: top; margin-right: 20px;",
               tags$div(
                 style = "position: absolute; top: 50%; right: -40px; transform: translate(0%, -50%); font-size: 30px; color: black;",
                 HTML("&#x2190;")
               )
             )
      ),
      column(4, offset = 0.5,  # Added offset to create a left margin
             imageOutput("image1", click = "image1_click")
      )
    ),
    fluidRow(
      column(4,
             div(
               textOutput("info2"),
               style = "font-size: 24px; border: 2px solid black; padding: 15px; position: relative; height: 250px; vertical-align: top; margin-right: 20px;",
               tags$div(
                 style = "position: absolute; top: 50%; right: -40px; transform: translate(0%, -50%); font-size: 30px; color: black;",
                 HTML("&#x2190;")
               )
             )
      ),
      column(4, offset = 0.5,  # Added offset to create a left margin
             imageOutput("image2", click = "image2_click")
      )
    ),
    fluidRow(
      column(4,
             div(
               textOutput("info3"),
               style = "font-size: 24px; border: 2px solid black; padding: 15px; position: relative; height: 250px; vertical-align: top; margin-right: 20px;",
               tags$div(
                 style = "position: absolute; top: 50%; right: -40px; transform: translate(0%, -50%); font-size: 30px; color: black;",
                 HTML("&#x2190;")
               )
             )
      ),
      column(4, offset = 0.5,  # Added offset to create a left margin
             imageOutput("image3", click = "image3_click")
      )
    ),
    tags$script('
      $(document).on("shiny:value", function(event) {
        var imageHeight = $("#image2 img").height();
        $(".info-box").css("height", imageHeight + "px");
      });
    ')
  )
)

server <- function(input, output, session) {
  output$image1 <- renderImage({
    list(src = "Image1.jpg", width = "200%", height = "auto", alt = "Image 1")
  }, deleteFile = FALSE)
  
  output$image2 <- renderImage({
    list(src = "Image2.jpg", width = "200%", height = "auto", alt = "Image 2")
  }, deleteFile = FALSE)
  
  output$image3 <- renderImage({
    list(src = "Image3.jpg", width = "200%", height = "auto", alt = "Image 3")
  }, deleteFile = FALSE)
  
  observeEvent(input$image1_click, {
    output$info1 <- renderText({
      paste(
        "Likecount: 1,984,198\n",
        "Replycount: 92,793\n",
        "Retweetcount: 400,770"
      )
    })
  })
  
  observeEvent(input$image2_click, {
    output$info2 <- renderText({
      paste(
        "Likecount: 1,124,468\n",
        "Replycount: 38,223\n",
        "Retweetcount: 354,664"
      )
    })
  })
  
  observeEvent(input$image3_click, {
    output$info3 <- renderText({
      paste(
        "Likecount: 848,969\n",
        "Replycount: 31,916\n",
        "Retweetcount: 184,135"
      )
    })
  })
}

shinyApp(ui, server)
