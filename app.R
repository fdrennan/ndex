library(ndex)
dotenv::load_dot_env()
sass(
  input = sass_file("./www/styles.scss"),
  output = "www/styles.css"
)


#' ui_body
#' @export
ui_body <- function(id = "main_panel") {
  ns <- NS(id)
  div(
    class='main-panel',
    uiOutput(ns("body"))
  )
}


#' server_body
#' @export
server_body <- function(id='main_panel') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      output$body <- renderUI({
        # filler <- filler_text(3)
        div(
          imap(
            list(
              h1 = h1,
              h2 = h2,
              h3 = h3,
              h4 = h4,
              h5 = h5,
              h6 = h6,
              p = tags$p,
              pre = tags$pre,
              em = tags$em,
              span = tags$span,
              strong = tags$strong,
              code = tags$code
            ), function(x, i) {
              div(
                class = "flex-center",
                hr(),
                h4(i),
                x("Example <- -> == ===")
              )
            }
          )
        )
      })
    }
  )
}

#' ui
#' @export
ui <- function(incoming) {
  fluidPage(
    includeCSS("www/styles.css"),
    ui_body()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  server_body()
}

shinyApp(
  ui = ui,
  server = server
)
