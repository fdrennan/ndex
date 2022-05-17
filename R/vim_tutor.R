#' ui_vim_tutor
#' @export
ui_vim_tutor <- function(id = "vimtutor") {
  ns <- NS(id)
  actionButton(ns("nons_vimmodal"), tags$i(class = "bi bi-journal-richtext"), class = "btn btn-link")
}

#' ndexModalDialog
#' @export
ndexModalDialog <- function(..., title = NULL, footer = modalButton("Dismiss"),
                            size = c("m", "s", "l", "xl", "xlg"), easyClose = FALSE, fade = TRUE) {
  size <- match.arg(size)
  backdrop <- if (!easyClose) {
    "static"
  }
  keyboard <- if (!easyClose) {
    "false"
  }
  div(
    id = "shiny-modal", class = "modal", class = if (fade) {
      "fade"
    }, tabindex = "-1", `data-backdrop` = backdrop,
    `data-bs-backdrop` = backdrop, `data-keyboard` = keyboard,
    `data-bs-keyboard` = keyboard, div(
      class = "modal-dialog",
      class = switch(size,
        s = "modal-sm",
        m = NULL,
        l = "modal-lg",
        xl = "modal-xl"
        # xlg = "modal-xlg" # dependent on current project scss
      ),
      class = "mw-100",
      div(
        class = "modal-content",
        if (!is.null(title)) {
          div(class = "modal-header", tags$h4(
            class = "modal-title",
            title
          ))
        }, div(class = "modal-body", ...),
        if (!is.null(footer)) {
          div(class = "modal-footer", footer)
        }
      )
    ), tags$script(HTML("if (window.bootstrap && !window.bootstrap.Modal.VERSION.match(/^4\\./)) {\n         var modal = new bootstrap.Modal(document.getElementById('shiny-modal'));\n         modal.show();\n      } else {\n         $('#shiny-modal').modal().focus();\n      }"))
  )
}

#' server_vim_tutor
#' @export
server_vim_tutor <- function(id = "vimtutor", credentials) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      lessons <- reactive({
        req(credentials())
        lessons <- vim_lessons()
      })

      # Return the UI for a modal dialog with data selection input. If 'failed' is
      # TRUE, then display a message that the previous value was invalid.
      dataModal <- function(failed = FALSE) {
        div(
          ndexModalDialog(size = "xl", easyClose = T, {
            lessons <- lessons()
            unique_lessons <- unique(lessons$lesson_tags)
            div(
              class = "container", style = "width: 1000px;",
              div(
                class = "row",
                div(
                  class = "col-lg-9 col-xl-9 p-1",
                  uiOutput(ns("ace"))
                ),
                div(
                  selectizeInput(ns("lessons"), NULL, unique_lessons, unique_lessons[[1]]),
                  numericInput(ns("fontSize"), "Font Size", 10, min = 5, max = 20, step = 1)
                ),
              )
            )
          })
        )
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
