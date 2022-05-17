library(ndex)
devtools::load_all()


smart_bar <- function() {
  div(
    class = "d-flex justify-content-between bg-light",
    actionButton("goHome",
      tags$i(class = "bi bi-house-fill"),
      class = "btn btn-link"
    ),
    ui_vim_tutor(),
    actionButton("goSettings",
      icon("user"),
      class = "btn btn-link"
    ),
    ui_logout()
  )
}

router <- make_router(
  route("get_inside", ui_get_inside(title = "sign up / login")),
  route("home", div(
    class = "px-1",
    ui_course()
  )), route("terminal", ui_terminal()),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

#' ui
#' @export
ui <- function(incoming) {
  print(incoming$HEADERS)
  html_page(
    title = "ndexr",
    # ui_navbar(),
    div(
      class = "",
      router$ui
    ),
    smart_bar(),
    ui_footer()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  observeEvent(input$goHome, change_page("home"))
  observeEvent(input$goSettings, change_page("settings"))

  server_get_inside()
  settings <- callModule(server_settings, "settings")
  server_course(settings = settings)

  server_vim_tutor()
  server_terminal()
  # server_navbar()
  server_footer(settings = settings)
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
