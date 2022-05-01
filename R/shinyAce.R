#' ui_shiny_ace
#' @export
ui_shiny_ace <- function(id = "shiny_ace") {
  ns <- NS(id)
  fluidRow(
    column(
      12,
      selectizeInput(ns("service"), h4("Service", class = "text-bold"), c("app", "shiny", "nginx")),
      uiOutput(ns("main"))
    )
  )
}

#' server_shiny_ace
#' @export
server_shiny_ace <- function(id = "shiny_ace") {
  moduleServer(
    id,
    function(input, output, session) {
      output$main <- renderUI({
        ns <- session$ns
        aceEditor(
          outputId = ns("ace"),
          selectionId = "selection",
          value = readr::read_file("R/app_body.R"),
          placeholder = "hmm..?"
        )
      })

      observe({
        updateAceEditor(
          session,
          "ace",
          theme = "ambience",
          mode = "r",
          tabSize = 4,
          useSoftTabs = TRUE,
          showInvisibles = TRUE
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
