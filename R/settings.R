#' ui_settings
#' @export
ui_settings <- function(id = "settings", user = "test") {
  ns <- NS(id)
  uiOutput(ns('settingsPanel'))
}

#' server_settings
#' @export
server_settings <- function(id='settings', credentials) {
  # browser()
  moduleServer(
    id,
    function(input, output, session) {
      # browser()
      output$settingsPanel <- renderUI({
        message('server_settings')
        # browser()
        req(credentials()$authorized)
        ns <- session$ns
        timeZone <- "UTC"
        emailMe <- FALSE
        div(
          class = "well p-4",
          div(class='p-1',
              selectizeInput(
                ns("timeZone"),
                "Preferred Time Zone",
                selected = timeZone,
                choices = OlsonNames()
              ),
              numericInput(ns("fontSize"), "Font Size", min = 5, max = 20, value = 16)
          ),
          div(
            class='d-flex justify-content-around p-2',
            checkboxInput(ns("emailMe"), "Email Me", value = emailMe),
            checkboxInput(ns("useVim"), "Use Vim", value = FALSE),
            checkboxInput(ns("minimal"), "Minimal", value = FALSE)
          )
        )
      })

      input
    }
  )
}
