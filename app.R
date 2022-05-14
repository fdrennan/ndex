library(ndex)
library(bcrypt)
devtools::load_all()

router <- make_router(
  route("get_inside", ui_get_inside(title = 'sign up / login')),
  route("home", ui_course()),
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
    actionButton("show", "vim", class='btn btn-info float-right'),
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

  # Return the UI for a modal dialog with data selection input. If 'failed' is
  # TRUE, then display a message that the previous value was invalid.
  dataModal <- function(failed = FALSE) {
    modalDialog(size = 'l', easyClose = T,
      ui_vim_tutor('vim-help'),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("ok", "OK")
      )
    )
  }

  # Show modal when button is clicked.
  observeEvent(input$show, {
    showModal(dataModal())
  })


  router$server(input, output, session)

  server_get_inside()
  server_course()
  server_vim_tutor('vim-help')
  server_terminal()
  server_navbar()
  server_footer()
  server_logout()
}

shinyApp(
  ui = ui,
  server = server
)
