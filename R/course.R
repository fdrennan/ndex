#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)
  print(ns(id))

  div(class = "row p-1",
    div(class = "col-lg-5 col-xl-5",
      uiOutput(ns("aceEditor"))
    ),
    div(class = "col-lg-7 col-xl-7",
      uiOutput(ns("output"))
    )
  )
}

#' server_course
#' ace_envir <- environment()
#' @export
server_course <- function(id = "course") {
  # use an environment to evaluate R code evaluated by knitr
  ace_envir <- environment()
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns


      output$aceEditor <- renderUI({
        init_value <- readr::read_file('courses/lesson_1.R')

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
      })
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
        # #
        # input$eval
        # input$code_run_key
        # input$submit
        #
        eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", input$code, "\n```\n")
        resp <- GET(url = "https://ndexr.com/api/code/markdown", query = list(
          code = eval_code
        ))
        resp <- content(resp, "text")
        HTML(resp)
      })
    }
  )
}
