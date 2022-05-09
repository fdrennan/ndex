library(ndex)
library(httr)

dotenv::load_dot_env()
devtools::load_all()

router <- make_router(
  route("/", h1("Home", class = "display-1 text-center")),
  route("terminal", ui_terminal()),
  route("about", h1("About", class = "display-1")),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

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
  # server_home()
  server_terminal()
  server_shiny_ace()
  server_navbar()
  server_footer()
  server_contact_us()
}

shinyApp(
  ui = ui,
  server = server
)
