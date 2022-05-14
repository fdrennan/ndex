#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)

  lessons <- vim_lessons()
  unique_lessons <- unique(lessons$lesson_tags)


  fluidRow(
    class = "m-2",
    column(
      4,
      class = "p-1",
      h4("Vim Lessons", class = "text-center"),
      div(
        class = "d-flex justify-content-center",
        selectizeInput(ns("lessons"), NULL, unique_lessons, unique_lessons[[1]])
      )
    ),
    column(
      8,
      uiOutput(ns("ace"))
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

      lessons <- reactive({
        lessons <- vim_lessons()
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
            fontSize = 14,
            vimKeyBinding = TRUE,
            showLineNumbers = TRUE, autoScrollEditorIntoView = T
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
