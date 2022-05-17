#' smart_bar
#' @export
smart_bar <- function(id = "smartbar") {
  ns <- NS(id)
  div(
    class = "d-flex justify-content-between bg-light mx-1 mb-1",
    actionButton(ns("goHome"),
      tags$i(class = "bi bi-house-fill"),
      class = "btn btn-link"
    ),
    ui_vim_tutor(),
    actionButton(ns("goSettings"),
      icon("user"),
      class = "btn btn-link"
    ),
    ui_logout()
  )
}

#' server_smart_bar
#' @export
server_smart_bar <- function(id = "smartbar") {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$goHome, change_page("home"))
      observeEvent(input$goSettings, change_page("settings"))
    }
  )
}
