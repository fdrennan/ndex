library(ndex)

dotenv::load_dot_env()
devtools::load_all()

router <- make_router(
  route("", ui_login(title = "sign up / login")),
  route("settings", ui_settings("settings", "testuser")),
  route("home", ui_course()),
  route("theme", bs_text_ui())
)

#' ui
#' @export
ui <- function() {
  div(
    # class = "d-flex flex-column min-vh-100",
    ui_smart_bar(),
    html_page(
      title = "ndexr",
      div(
        class = "flex-grow-1",
        router$ui
      ),
      ui_footer()
    )
  )
}

#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  credentials <- server_login(logged_in = FALSE)
  settings <- server_settings(credentials = credentials)
  server_course(settings = settings, credentials = credentials)
  server_vim_tutor(credentials = credentials)
  server_smart_bar()
  server_footer(settings = settings, credentials = credentials)
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
