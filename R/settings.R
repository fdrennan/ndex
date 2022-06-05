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

        defaults <- get_defaults(ns(email()))
        timeZone <- setDefault(defaults$timeZone, "UTC")
        emailMe <- setDefault(defaults$emailMe, TRUE)
        useVim <- setDefault(defaults$useVim, TRUE)
        minimal <- setDefault(defaults$minimal, FALSE)
        goToSettings <- setDefault(defaults$goToSettings, TRUE)
        div(
          class = "row",
          div(class = "col-lg-4 col-xl-4 col-md-4"),
          div(
            class = "col-lg-4 col-xl-4 col-md-4",
            div(
              class = "well p-4",
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
                checkboxInput(ns("minimal"), "Minimal", value = minimal)
              ),
              div(
                class = "d-flex justify-content-center p-2",
                actionButton(ns("submit"), "Update and Go to Course", class = "btn btn-primary float-end my-2")
              )
            )
          )
        )
      })

      observe({
        req(input$submit)
        showNotification("Settings Updated")
        change_page("home")
      })

      observe({
        req(email())
        input <- toJSON(reactiveValuesToList(input))
        print(input)
        r <- connect_redis()
        r$SET(ns(email()), input)
      })

      input
    }
  )
}
