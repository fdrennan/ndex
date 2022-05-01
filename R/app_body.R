#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    router$ui,
    ui_footer()
  )
}



#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  server_home()
  server_shiny_ace()
  server_navbar()
  server_footer()
}
