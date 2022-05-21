#' ui_settings
#' @export
ui_settings <- function(id = "settings", user = "test") {
  ns <- NS(id)
  uiOutput(ns("settingsPanel"))
}

#' server_settings
#' @export
server_settings <- function(id = "settings", credentials) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      email <- reactive({
        email <- credentials()()$email
      })

      output$settingsPanel <- renderUI({
        #
        req(email())
        r <- connect_redis()
        defaults <- r$GET(ns(email()))
        if (is.null(defaults)) {
          defaults <- list()
        } else {
          defaults <- fromJSON(defaults)
        }
        timeZone <- setDefault(defaults$timeZone, "UTC")
        emailMe <- setDefault(defaults$emailMe, TRUE)
        useVim <- setDefault(defaults$useVim, TRUE)
        minimal <- setDefault(defaults$minimal, FALSE)
        navTop <- setDefault(defaults$navTop, TRUE)
        course <- setDefault(defaults$course, 'purrr')
        div(
          class = "row",
          div(class = "col-lg-4 col-xl-4 col-md-4"),
          div(
            class = "col-lg-4 col-xl-4 col-md-4",
            div(
              class = "well p-4",
              div(
                class = "p-4 d-flex justify-content-center",
                selectizeInput(ns("course"), h3("Select Course"), c("vim", "purrr"),course)
              ),
              div(
                class = "p-1",
                selectizeInput(
                  ns("timeZone"),
                  "Preferred Time Zone",
                  selected = timeZone,
                  choices = OlsonNames()
                ),
                numericInput(ns("fontSize"), "Font Size", min = 5, max = 20, value = 16),
              ),
              div(
                class = "d-flex justify-content-around p-2",
                checkboxInput(ns("emailMe"), "Email Me", value = emailMe),
                checkboxInput(ns("useVim"), "Use Vim", value = useVim),
                checkboxInput(ns("minimal"), "Minimal", value = minimal),
                checkboxInput(ns("navTop"), "Nav Top", value = navTop),
              ),
              div(
                class = "d-flex justify-content-center",
                actionButton(ns("update"), "Save Settings", class = "btn btn-primary btn-block")
              )
            )
          )
        )
      })

      observe({
        req(email())
        input <- toJSON(reactiveValuesToList(input))
        r <- connect_redis()
        showNotification("Settings Updated")
        r$SET(ns(email()), input)
      })

      input
    }
  )
}
