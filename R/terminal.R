#' ui_terminal
#' @export
ui_terminal <- function(id = "terminal", init_value = "print(mtcars)") {
  ns <- NS(id)
  print(ns(id))
  # init <- "print('gotta use vim lol')"
  fluidRow(
    class = "terminal-all my-4 mx-1",
    column(
      4,
      aceEditor(
        ns("code"),
        mode = "r",
        selectionId = ns("selection"),
        code_hotkeys = list(
          "r",
          list(
            run_key = list(
              win = "CTRL-ENTER|SHIFT-ENTER",
              mac = "CMD-ENTER|SHIFT-ENTER"
            )
          )
        ),
        value = init_value,
        autoComplete = "enabled",
        fontSize = 16,
        vimKeyBinding = TRUE,
        showLineNumbers = TRUE
      )
    ),
    column(
      8,
      uiOutput(ns("output"))
    )
  )
}

#' server_terminal
#' ace_envir <- environment()
#' @export
server_terminal <- function(id = "terminal") {
  # use an environment to evaluate R code evaluated by knitr
  ace_envir <- environment()
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      observe({
        input
        print(ns(id))
      })

      code <- reactiveVal("")

      crc <- reactive({
        input
        input$code_run_key
      })
      observeEvent(crc, {
        if (!is.empty(crc()$selection)) {
          code(crc()$selection)
        } else {
          code(crc()$line)
        }
      })

      observeEvent(input$eval, {
        if (!is.empty(input$code_selection)) {
          code(input$code_selection)
        } else {
          code(input$code)
        }
      })

      output$output <- renderUI({
        input
        # # browser()
        # input$eval
        # input$code_run_key
        # input$submit
        # browser()
        eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", input$code, "\n```\n")
        resp <- GET(url = "http://192.168.0.51/api/code/markdown", query = list(
          code = eval_code
        ))
        resp <- content(resp, "text")
        HTML(resp)
      })
    }
  )
}
