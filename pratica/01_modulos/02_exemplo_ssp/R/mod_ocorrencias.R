mod_ocorrencias_ui <- function(id, dados) {
  ns <- NS(id)
  tab <- dados |>
    dplyr::select(estupro:vit_latrocinio)
  menor_data <- min(dados$data)
  maior_data <- max(dados$data)
  tagList(
    bslib::card(
      h6("Filtros"),
      fluidRow(
        column(
          width = 4,
          dateRangeInput(
            inputId = ns("periodo"),
            label = "Selecione um período",
            start = menor_data,
            min = menor_data,
            end = menor_data,
            max = maior_data
          )
        ),
        column(
          width = 4,
          varSelectInput(
            inputId = ns("ocorrencia"),
            label = "Selecione uma ocorrência",
            data = tab
          )
        )
      )
    ),
    bslib::layout_columns(
      col_widths = c(3, 3, 3, 3),
      uiOutput(ns("valor_medio")),
      uiOutput(ns("delegacia_mais_ocorrencias")),
      uiOutput(ns("municipio_mais_ocorrencias")),
      uiOutput(ns("mes_ano_mais_ocorrencias"))
    ),
    bslib::card(
      h6("Série histórica"),
      echarts4r::echarts4rOutput("serie_historica")
    )
  )
}

mod_ocorrencias_server <- function(id, dados) {
  moduleServer(id, function(input, output, session) {

    dados_filtrados <- reactive({
      dados |>
        dplyr::filter(
          data >= input$periodo[[1]],
          data <= input$periodo[[2]]
        )
    })

    output$serie_historica <- echarts4r::renderEcharts4r({
      dados_filtrados() |>
        echarts4r::e_chart(x = data) |>
        echarts4r::e_line_(serie = input$ocorrencia)
    })

  })
}
