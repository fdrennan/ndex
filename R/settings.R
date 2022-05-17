#' ui_settings
#' @export
ui_settings <- function(id = "settings", user = "test") {
  ns <- NS(id)
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
}

#' server_settings
#' @export
server_settings <- function(input, output, session) {
  return(input)
}
