library(ndex)
library(bcrypt)
devtools::load_all()

router <- make_router(
  # route("get_inside", ui_get_inside(title = "sign up / login")),
  route("home", div(ui_course(), ui_vim_tutor())),
  route("terminal", ui_terminal()),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

#' ui
#' @export
ui <- function(incoming) {
  print(incoming$HEADERS)
  html_page(
    title = "ndexr",
    ui_navbar(),
    div(
      class = "",
      router$ui
    ),
    ui_footer()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  server_get_inside()
  server_course()
  server_vim_tutor()
  server_terminal()
  server_navbar()
  server_footer()
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
