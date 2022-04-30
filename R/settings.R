#' ui_settings
#' @export
ui_settings <- function(id = "user_settings", user) {
  ns <- NS(id)
  # state <- get_redis_user_state(ns(user))
  # timeZone <- setDefault(state$timeZone, "UTC")
  # emailMe <- setDefault(state$emailMe, TRUE)
  timeZone <- "UTC"
  emailMe <- FALSE
  div(
    div(
      class = "ndex-input-panel",
      div(class = "card-header", "Application"),
      div(
        class = "p-2 card-body",
        selectizeInput(
          ns("timeZone"),
          "Preferred Time Zone",
          selected = timeZone,
          choices = OlsonNames()
        )
      ),
      div(
        class = "p-2",
        checkboxInput(ns("emailMe"), "Email Me", value = emailMe)
      )
    )
  )
}

#' server_settings
#' @export
server_settings <- function(input, output, session, user_name) {
  observe({
    ns <- session$ns
    update_state(input, ns(user_name()))
  })

  return(input)
}
