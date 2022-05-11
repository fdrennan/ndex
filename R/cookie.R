


ui_cookie <- function(id = "cookie") {
  ns <- NS(id)
  div(
    textInput(ns("name_set"), "What is your name?"),
    actionButton(ns("save"), "Save cookie"),
    actionButton(ns("remove"), "remove cookie"),
    uiOutput(ns("name_get"))
  )
}

server_cookie <- function(id = "cookie") {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$save, {
        msg <- list(
          name = "name", value = input$name_set
        )

        if (input$name_set != "") {
          session$sendCustomMessage("cookie-set", msg)
        }
      })

      # delete
      observeEvent(input$remove, {
        msg <- list(name = "name")
        session$sendCustomMessage("cookie-remove", msg)
      })

      # output if cookie is specified
      output$name_get <- renderUI({
        if (!is.null(input$cookies$name)) {
          h3("Hello,", input$cookies$name)
        } else {
          h3("Who are you?")
        }
      })
    }
  )
}
