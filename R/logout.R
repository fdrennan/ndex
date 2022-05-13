#' ui_signup
#' @export
ui_logout <- function(id = "logout") {
  ns <- NS(id)
  div(
    actionButton(ns("submit"), "Logout", class = "btn btn-danger btn-block")
  )
}

#' server_signup
#' @export
server_logout <- function(id = "logout") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$submit, {
        shinyjs::runjs(glue('window.location.href = "https://ndexr.com/api/user/logout";'))
      })
    }
  )
}
