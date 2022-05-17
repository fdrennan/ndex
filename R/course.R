#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)
  print(ns(id))

  div(class='row',
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

      is_auth <- reactive({
        req(credentials()$authorized)
        # req(settings$authorized)
      })
      page <-
        reactive({
          input$increment - input$decrement + 1
        })

      init_value <- reactive({
        course_internals(page())
      })

      output$coursePanel <- renderUI({
        # browser()
        req(is_auth())
        # settings <- settings()
        navButtons <- function() {
          div(
            class='d-flex justify-content-between',
            actionButton(ns("decrement"), "Back", class = "btn btn-light"),
            actionButton(ns("increment"), "Next", class = "btn btn-light")
          )
        }
        div(
          div(
            class = "row",
            {
              if (settings$navTop) {
                div(class='pb-4', navButtons())
              } else {
                div()
              }
            },
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
              div(class='pb-4', navButtons())
            } else {
              div()
            }
          }
        )
      })

      output$classHtml <- renderUI({
        init_value()$lesson_html
      })

      output$aceEditor <- renderUI({
        # init_value <- readr::read_file('courses/lesson_1.R')
        init_value <- init_value()$code

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
