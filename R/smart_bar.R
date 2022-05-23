#' ui_smart_bar
#' @export
ui_smart_bar <- function(id = "smartbar") {
  ns <- NS(id)
  div(
    class = "d-flex justify-content-around bg-dark text-light m-0 p-2",
    ui_logout(),
    actionButton(ns("goSettings"),
                 icon("user"),
                 class = "btn btn-link"
    ),
    actionButton(ns("goHome"),
      tags$i(class = "bi bi-house-fill"),
      class = "btn btn-link"
    )
    # ui_vim_tutor()
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
