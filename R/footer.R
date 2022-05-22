#' ui_footer
#' @export
ui_footer <- function(id = "footer") {
  ns <- NS(id)
  uiOutput(ns("footer"))
}

#' server_footer
#' @export
server_footer <- function(id = "footer", settings, credentials) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      output$footer <- renderUI({
        hide_footer <- isTRUE(settings$minimal)
        if (hide_footer) {
          return(div())
        }
        tags$footer(
          class = "bg-dark text-center text-white p-0 m-0",
          div(
            class = "container",
            ui_social_links(),
            other_links(),
            div(
              class = "text-center",
              "© 2022 Copyright:",
              tags$a(class = "text-white", href = "https://ndexr.com", "ndexr")
            )
          )
        )
      })
    }
  )
}
