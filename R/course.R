#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)
  div(
    class = "row",
    uiOutput(ns("coursePanel"))
  )
}

#' server_course
#' ace_envir <- environment()
#' @export
server_course <- function(id = "course", settings, credentials) {
  # use an environment to evaluate R code evaluated by knitr
  ace_envir <- environment()
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      authorized <- reactive({
        req(credentials()$authorized)
      })

      page <-
        reactive({
          input$increment - input$decrement + 1
        })

      init_value <- reactive({
        course_internals(page())
      })

      output$coursePanel <- renderUI({
        req(authorized())
        # req(settings$navTop)
        navButtons <- function() {
          div(
            class = "d-flex justify-content-between",
            actionButton(ns("decrement"), "Back", class = "btn btn-light"),
            actionButton(ns("increment"), "Next", class = "btn btn-light")
          )
        }
        div(
          div(
            class = "row",
            div({
              if (settings$navTop) {
                div(class = "pb-4", navButtons())
              }
            }),
            div(
              class = "col-lg-3 col-xl-3",
              uiOutput(ns("classHtml"))
            ),
            div(
              class = "col-lg-4 col-xl-4",
              uiOutput(ns("aceEditor"))
            ),
            div(
              class = "col-lg-5 col-xl-5",
              uiOutput(ns("output"))
            )
          ),
          {
            if (!settings$navTop) {
              div(class = "pb-4", navButtons())
            }
          }
        )
      })

      output$aceEditor <- renderUI({

        course_internals <- course_internals(page())
        init_value <- course_internals$code

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
          fontSize = settings$fontSize,
          vimKeyBinding = settings$useVim,
          showLineNumbers = TRUE,
          height = "200px"
        )
      })

      code <- reactiveVal("")

      crc <- reactive({
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

      output$classHtml <- renderUI({
        req(authorized())
        course_internals <- course_internals(page())
        course_internals$lesson_html
      })

      output$output <- renderUI({
        input
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
