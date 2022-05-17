#' ui_get_inside
#' @export
ui_logout <- function(id = "logout") {
  ns <- NS(id)
  actionButton(ns("submit"), tags$i(class = "bi bi-x btn py-0"))
}

#' server_get_inside
#' @export
server_logout <- function(id = "logout") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$submit, {
        showNotification("Logging Out")
        change_page("get_inside")
      })
    }
  )
}
