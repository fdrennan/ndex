#' ui_vim_tutor
#' @export
ui_vim_tutor <- function(id = "vimtutor") {
  ns <- NS(id)
  actionButton(ns('nons_vimmodal'), tags$small('vimtutor'), class='px-1 m-0 btn text-underline')
}

#' server_vim_tutor
#' @export
server_vim_tutor <- function(id = "vimtutor") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      lessons <- reactive({
        lessons <- vim_lessons()
      })

      # Return the UI for a modal dialog with data selection input. If 'failed' is
      # TRUE, then display a message that the previous value was invalid.
      dataModal <- function(failed = FALSE) {
        modalDialog(size = "xl", easyClose = T, {
          lessons <- lessons()
          unique_lessons <- unique(lessons$lesson_tags)
          div(
            class = "container",
            div(
              class = "row",
              div(
                class = "d-flex justify-content-center",
                numericInput(ns("fontSize"), "Font Size", 12, min = 7, max = 20, step = 1)
              )
            ),
            div(
              class = "row",
              div(
                class = "col-lg-3 col-xl-3",
                h4("Vim Lessons", class = "text-center"),
                div(
                  class = "d-flex justify-content-center",
                  selectizeInput(ns("lessons"), NULL, unique_lessons, unique_lessons[[1]])
                )
              ),
              div(
                class = "col-lg-9 col-xl-9 p-1",
                uiOutput(ns("ace"))
              )
            )
          )
        })
      }

      # Show modal when button is clicked.
      observeEvent(input$nons_vimmodal, {
        showModal(dataModal())
      })


      output$ace <- renderUI({
        input$lessons
        lessons <- filter(
          lessons(),
          lesson_tags == input$lessons
        )
        div(
          class = "terminal-all p-1",
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
            value = lessons$lines,
            autoComplete = "enabled",
            fontSize = input$fontSize,
            vimKeyBinding = TRUE,
            showLineNumbers = TRUE,
            autoScrollEditorIntoView = T
          )
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

      # output$output <- renderUI({
      #   # input
      #   # #
      #   input$eval
      #   input$code_run_key
      #   # input$submit
      #   #
      #   eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", input$code, "\n```\n")
      #   resp <- GET(url = "http://192.168.0.51/api/code/markdown", query = list(
      #     code = eval_code
      #   ))
      #   resp <- content(resp, "text")
      #   HTML(resp)
      # })
    }
  )
}


#' vim_lessons
#' @export
vim_lessons <- function() {
  init <- read_lines("http://www2.geog.ucl.ac.uk/~plewis/teaching/unix/vimtutor")

  lessons <- str_extract(init, "Lesson [0-9][.][0-9]:")
  lessons[1] <- "Introduction"

  lesson_tags <-
    lessons %>%
    reduce(
      function(x, y) {
        if (is.na(y)) {
          return(c(x, last(x)))
        }
        return(c(x, y))
      }
    )

  lessons <- tibble(lesson_tags = lesson_tags, lines = init) %>%
    filter(lesson_tags != "Introduction") %>%
    group_by(lesson_tags) %>%
    mutate(first_line = first(lines)) %>%
    transmute(
      lesson_tags = str_trim(first_line),
      lines = lines
    ) %>%
    ungroup()
  lessons
}
