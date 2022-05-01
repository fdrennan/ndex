#' up_home
#' @export
ui_home <- function(id = "home") {
  ns <- NS(id)
  fluidRow(
  )
}

#' server_home
#' @export
server_home <- function(id = "home") {
  moduleServer(
    id,
    function(input, output, session) {
      observe(print(input))
    }
  )
}
