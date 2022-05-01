#' ui_shiny_ace
#' @export
ui_shiny_ace <- function(id='shiny_ace') {
  ns <- NS(id)
  modes <- getAceModes()
  themes <- getAceThemes()

    init <- "createData <- function(rows) {
    data.frame(col1 = 1:rows, col2 = rnorm(rows))
  }"

  pageWithSidebar(
    headerPanel("Simple Shiny Ace!"),
    sidebarPanel(
      selectInput(ns("mode"), "Mode: ", choices = modes, selected = "r"),
      selectInput(ns("theme"), "Theme: ", choices = themes, selected = "ambience"),
      numericInput(ns("size"), "Tab size:", 4),
      radioButtons(ns("soft"), NULL, c("Soft tabs" = TRUE, "Hard tabs" = FALSE), inline = TRUE),
      radioButtons(ns("invisible"), NULL, c("Hide invisibles" = FALSE, "Show invisibles" = TRUE), inline = TRUE),
      actionButton(ns("reset"), "Reset text"),
      actionButton(ns("clear"), "Clear text"),
      HTML("<hr />"),
      helpText(HTML("A simple Shiny Ace editor.
                  <p>Created using <a href = \"http://github.com/trestletech/shinyAce\">shinyAce</a>."))
    ),
    mainPanel(
      aceEditor(
        outputId = ns("ace"),
        # to access content of `selectionId` in server.R use `ace_selection`
        # i.e., the outputId is prepended to the selectionId for use
        # with Shiny modules
        selectionId = "selection",
        value = init,
        placeholder = "Show a placeholder when the editor is empty ..."
      )
    )
  )
}

#' server_shiny_ace
#' @export
server_shiny_ace <- function(id='shiny_ace') {
  moduleServer(
    id,
    function(input, output, session) {
      observe({
        # print all editor content to the R console
        cat(input$ace, "\n")
      })

      observe({
        # print only selected editor content to the R console
        # to access content of `selectionId` use `ace_selection`
        # i.e., the outputId is prepended to the selectionId for
        # use with Shiny modules
        cat(input$ace_selection, "\n")
      })

      observe({
        updateAceEditor(
          session,
          "ace",
          theme = input$theme,
          mode = input$mode,
          tabSize = input$size,
          useSoftTabs = as.logical(input$soft),
          showInvisibles = as.logical(input$invisible)
        )
      })

      observeEvent(input$reset, {
        updateAceEditor(session, "ace", value = init)
      })

      observeEvent(input$clear, {
        updateAceEditor(session, "ace", value = "")
      })
    }
  )
}
