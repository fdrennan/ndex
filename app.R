library(ndex)

dotenv::load_dot_env()
devtools::load_all()

router <- make_router(
  route("", ui_get_inside(title = "sign up / login")),
  route("settings", ui_settings("settings", "testuser")),
  route("home", ui_course()),
  route("theme", bs_text_ui())
)

#' ui
#' @export
ui <- function(incoming) {
  div(
    class = "h-auto d-flex flex-column justify-content-between",
    html_page(
      title = "ndexr",
      ui_smart_bar(),
      div(
        class = "py-1",
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
  credentials <- server_get_inside(logged_in = FALSE)
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
