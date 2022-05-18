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
#' @export
server_course <- function(id = "course", settings, credentials) {
  # use an environment to evaluate R code evaluated by knitr
  ace_envir <- environment()
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      authorized <- reactive({
        req(credentials()()$authorized)
        req(is.logical(settings$navTop))
      })

      page <-
        reactive({
          authorized()
          current_page <- input$increment - input$decrement + 1
          print(glue("Moving to page {current_page}"))
          current_page
        })

      init_value <- reactive({
        course_internals(page())
      })

      output$coursePanel <- renderUI({
        req(authorized())
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
        req(authorized())
        req(settings$fontSize)
        req(settings$useVim)
        course_internals <- init_value()
        init_value <- course_internals$code
        if (course_internals$display_editor) {
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
        } else {
          div()
        }
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
        req(authorized())
        course_internals <- course_internals(page())
        if (course_internals$display_editor) {
          eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", input$code, "\n```\n")
          resp <- GET(url = "https://ndexr.com/api/code/markdown", query = list(
            code = eval_code
          ))
          resp <- content(resp, "text")
          HTML(resp)
        } else {
          div()
        }
      })
    }
  )
}
