library(ndex)
library(httr)
# dotenv::load_dot_env()
devtools::load_all()

router <- make_router(
  route("/", ui_course()),
  route("terminal", ui_terminal()),
  route("about", h1("About", class = "display-1")),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)

#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    textInput("name_set", "What is your name?"),
    actionButton("save", "Save cookie"),
    actionButton("remove", "remove cookie"),
    uiOutput("name_get"),
    router$ui,
    ui_footer()
  )
}

#' server
#' @export
server <- function(input, output, session) {
  observeEvent(input$save, {
    msg <- list(
      name = "name", value = input$name_set
    )

    if(input$name_set != "")
      session$sendCustomMessage("cookie-set", msg)
  })

  # delete
  observeEvent(input$remove, {
    msg <- list(name = "name")
    session$sendCustomMessage("cookie-remove", msg)
  })

  # output if cookie is specified
  output$name_get <- renderUI({
    if(!is.null(input$cookies$name))
      h3("Hello,", input$cookies$name)
    else
      h3("Who are you?")
  })





  router$server(input, output, session)

  server_course()
  server_terminal()

  # server_course()
  server_navbar()
  server_footer()
  server_contact_us()
}

shinyApp(
  ui = ui,
  server = server
)
