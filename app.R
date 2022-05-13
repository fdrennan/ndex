library(ndex)
library(bcrypt)
devtools::load_all()

router <- make_router(
  route("signup", ui_signup()),
  route('login', ui_login()),
  route("home", ui_course()),
  route("terminal", ui_terminal()),
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
  server_course()
  server_signup()
  server_login()
  server_terminal()
  server_navbar()
  server_footer()
  server_contact_us()
}

shinyApp(
  ui = ui,
  server = server
)
