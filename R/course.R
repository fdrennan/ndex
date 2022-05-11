#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)

  init <- "print('gotta use vim lol')"
  fluidRow(
    h3("R Consulting and Education", class = "display-3 text-center"),
    column(
      4,
      div(
        class = "p-1",
        h3("Course coming soon!", class = "text-center")
      )
    ),
    column(
      8,
      fluidRow(
        class = "terminal-all p-1S",
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
          value = init,
          autoComplete = "enabled",
          fontSize = 16,
          vimKeyBinding = TRUE,
          showLineNumbers = TRUE
        ),
        uiOutput(ns("output"))
      )
    )
  )
}

#' server_course
#' @export
server_course <- function(id = "course") {
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
        # input
        # # browser()
        input$eval
        input$code_run_key
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
