library(ndex)
library(bcrypt)
devtools::load_all()

router <- make_router(
  route("signup", ui_signup(title = 'sign up')),
  route("login", ui_signup('login', title = 'log in')),
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
    ui_footer(),
    ui_logout()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  server_signup()
  server_signup('login', login = TRUE)
  server_course()
  server_terminal()
  server_navbar()
  server_footer()
  server_contact_us()
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
