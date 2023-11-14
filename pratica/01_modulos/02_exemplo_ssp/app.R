

library(shiny)

dados <- readRDS(
  here::here("dados/ssp.rds")
) |>
  dplyr::mutate(
    data = lubridate::make_date(
      year = ano,
      month = mes,
      day = 1
    ),
    .before = 1
  )

ui <- bslib::page_navbar(
  title = "Painel SSP",
  bslib::nav_panel(
    title = "Ocorrências",
    mod_ocorrencias_ui("ocorrencias_ui_1", dados)
  ),
  bslib::nav_panel(
    title = "Delegacia"
  ),
  bslib::nav_panel(
    title = "Município"
  )
)

server <- function(input, output, session) {
  mod_ocorrencias_server("ocorrencias_ui_1", dados)
}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))


