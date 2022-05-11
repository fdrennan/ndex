library(ndex)

devtools::load_all()

router <- make_router(
  route('login', ui_login()),
  route("signup", ui_signup()),
  route("home", ui_course()),
  route("terminal", ui_terminal()),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser")),
  route("cookie", ui_cookie())
)

#' ui
#' @export
ui <- function(incoming) {
  # browser()

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
  output$ui <- renderUI({
    browser()
  })
  server_course()
  server_signup()
  server_login()
  server_terminal()
  server_navbar()
  server_footer()
  server_contact_us()
  server_cookie()
}

shinyApp(
  ui = ui,
  server = server
)
