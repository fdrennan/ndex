library(ndex)
router <- make_router(
  route("get_inside", ui_get_inside(title = "sign up / login")),
  route("home", div(
    class = "p-1",
    ui_course()
  )), route("terminal", ui_terminal()),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    smart_bar(),
    div(
      class='p-2',
      router$ui
    ),
    ui_footer()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)

  # authorization <-
  server_get_inside()
  # observeEvent(authorization, {
  #   message('In server')
  #   print(authorization)
  # })
  settings <- callModule(server_settings, "settings")
  server_course(settings = settings)

  server_vim_tutor()
  server_terminal()
  server_smart_bar()
  server_footer(settings = settings)
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
