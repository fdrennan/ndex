
#' ui_body
#' @export
ui_template <- function(id = "main_panel") {
  ns <- NS(id)
  div(
    class = "main-panel",
    uiOutput(ns("body"))
  )
}


#' server_body
#' @export
server_template <- function(id = "main_panel") {
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
              fluidRow(
                class = "fallin",
                column(
                  3,
                  div(h4(i), class = "flex-center centerit")
                ),
                column(
                  9,
                  x("Example <- -> == ===")
                )
              )
            }
          )
        )
      })
    }
  )
}
