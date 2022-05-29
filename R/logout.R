#' ui_login
#' @export
ui_logout <- function(id = "logout") {
  ns <- NS(id)
  actionButton(ns("submit"), tags$i(class = "bi bi-x btn py-0"))
}

#' server_login
#' @export
server_logout <- function(id = "logout") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$submit, {
        change_page("/")
      })
    }
  )
}
