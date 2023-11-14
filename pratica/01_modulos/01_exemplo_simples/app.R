library(shiny)

ui <- fluidPage(
  titlePanel("Exemplo simples com mtcars"),
  hr(),
  mod_grafico_dispersao_ui("mod_grafico_dispersao_1")
)

server <- function(input, output, session) {
  mod_grafico_dispersao_server("mod_grafico_dispersao_1")
}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
