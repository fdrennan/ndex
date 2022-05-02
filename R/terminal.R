ui_terminal <- function(id = "terminal") {
  ns <- NS(id)
  init <- "fs::dir_info()"

  fluidRow(
    column(
      4,
      aceEditor(
        ns("code"),
        mode = "r",
        selectionId = "selection",
        code_hotkeys = list(
          "r",
          list(
            run_key = list(
              win = "CTRL-ENTER|SHIFT-ENTER",
              mac = "CMD-ENTER|SHIFT-ENTER"
            )
          )
        ),
        value = init
      )
    ),
    column(
      8,
      htmlOutput(ns("output"))
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

      # using a reactive value so we can use either the
      # action button or hotkeys (see ui.R)
      code <- reactiveVal("")

      observeEvent(input$code_run_key, {
        if (!is.empty(input$code_run_key$selection)) {
          code(input$code_run_key$selection)
        } else {
          code(input$code_run_key$line)
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
        input$eval
        input$code_run_key
        eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", code(), "\n```\n")
        div(
          class = "terminal",
          HTML(knitr::knit2html(text = eval_code, fragment.only = TRUE, quiet = TRUE, envir = ace_envir))
        )
      })
    }
  )
}
