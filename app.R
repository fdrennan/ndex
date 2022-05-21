library(ndex)
dotenv::load_dot_env()
devtools::load_all()

router <- make_router(
  route("get_inside", ui_get_inside(title = "sign up / login")),
  route("home", div(
    class = "p-1",
    ui_course()
  )),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_smart_bar(),
    div(
      class = "p-2",
      router$ui
    ),
    ui_footer()
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
