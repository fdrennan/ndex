#' ui_signup
#' @export
ui_logout <- function(id = "logout") {
  ns <- NS(id)
  actionButton(ns("submit"), h4("Logout"), class = "btn btn-danger btn-block p-1")
}

#' server_signup
#' @export
server_logout <- function(id = "logout") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$submit, {
        showNotification('Logging Out')
        shinyjs::runjs(glue('window.location.href = "https://ndexr.com/api/user/logout";'))
      })
    }
  )
}
