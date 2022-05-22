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
      })

      init_value <- reactive({
        req(authorized())
        current_page <- input$nextbutton - input$prevbutton + 1
        out <- course_internals(current_page)
        out
      })


      output$courseMainPanel <- renderUI({
        req(authorized())
        course_internals <- init_value()

        if (course_internals$display_editor) {
          out <- div(
            class = "row p-2",
            div(class = "col-lg-3 col-xl-3"),
            div(
              class = "col-lg-6 col-xl-6 p-3",
              course_internals$header
            ),
            div(class = "col-lg-3 col-xl-3"),
            div(
              class = "col-lg-4 col-xl-4 p-3",
              uiOutput(ns("classHtml"))
            ),
            div(
              class = "col-lg-4 col-xl-4 p-3",
              uiOutput(ns("aceEditor"))
            ),
            div(
              class = "col-lg-4 col-xl-4 p-3",
              uiOutput(ns("output"))
            )
          )
        } else {
          out <- div(
            class = "row p-2 h-100",
            div(
              class = "col-lg-3 col-xl-3 col-md-2 col-sm-2 col-xs-2"
            ),
            div(
              class = "col-lg-6 col-xl-6 col-md-8 col-sm-8 col-xs-8",
              course_internals$header,
              course_internals$lesson_html
            )
          )
        }

        out
      })


      output$coursePanel <- renderUI({
        req(authorized())
        withTags(
          div(
            id = "carouselExampleIndicators",
            class = "carousel slide", `data-ride` = "carousel",
            div(
              class = "carousel-inner",
              uiOutput(ns("courseMainPanel"))
            ),
            button(
              id = ns("prevbutton"),
              class = "carousel-control-prev action-button",
              role = "button",
              span(class = "carousel-control-prev-icon", `aria-hidden` = "true"),
              span(class = "sr-only", "Previous")
            ),
            button(
              id = ns("nextbutton"),
              class = "carousel-control-next action-button", role = "button",
              span(class = "carousel-control-next-icon", `aria-hidden` = "true"),
              span(class = "sr-only", "Next")
            )
          )
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
        course_internals <- init_value()
        course_internals$lesson_html
      })

      output$output <- renderUI({
        req(authorized())
        course_internals <- init_value()
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
