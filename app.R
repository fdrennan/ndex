library(shiny)
library(httr)
library(jsonlite)
library(purrr)
library(sass)
library(glue)
dotenv::load_dot_env()
sass(input = sass_file('./www/styles.scss'),
     output = "www/styles.css")

#' filler_text
#' @param n_sentences The number of sentences to return.
#' @export
# filler_text <-
#   function(n_sentences = 10) {
#     out <-
#       fromJSON(
#       content(
#         GET(url = "https://baconipsum.com/api/", query = list(
#           type = "meat-and-filler",
#           sentences = n_sentences
#         )), "text"
#       )
#     )
#
#     paste0(strsplit(out, '\\. ')[[1]], ".")
#   }

#' main_panel
#' @export
main_panel <- function(id = "main_panel") {
  ns <- NS(id)
  fluidPage(
    includeCSS("www/styles.css"),
    uiOutput(ns("body"))
  )
}


#' main_panel_server
#' @export
main_panel_server <- function(input, output, session) {
  ns <- session$ns
  output$body <- renderUI({
    # filler <- filler_text(3)
    fluidRow(
      column(
        6, offset=3,
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
            div(class='flex-center',
              hr(),
              h4(i),
              div(x("Example <- -> == ==="))
            )
          }
        )
      )
    )
  })
}

#' ui
#' @export
ui <- function(incoming) {
  fluidPage(main_panel("main_panel"))
}

#' server
#' @export
server <- function(input, output, session) {
  callModule(main_panel_server, "main_panel")
}

shinyApp(
  ui = ui,
  server = server
)
