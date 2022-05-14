#' ui_navbar
#' @export
ui_navbar <- function(id = "navbar", navbarId = "navbarNav") {
  ns <- NS(id)
  id <- ns("navbarNav")
  id_hash <- paste0("#", id)
  withTags(
    nav(
      class = "navbar navbar-expand-lg navbar-dark bg-dark",
      a(class = "navbar-brand", href = "/#!/home", i(class = "bi bi-house-door-fill")),
      button(
        id = ns("collapse"),
        class = "navbar-toggler action-button",
        type = "button",
        `data-bs-toggle` = "collapse",
        `data-bs-target` = paste0("#", id),
        `aria-controls` = id,
        `aria-expanded` = "false",
        `aria-label` = "Toggle navigation",
        span(class = "navbar-toggler-icon")
      ),
      div(
        class = "collapse navbar-collapse flex-row-reverse",
        id = id,
        ul(
          class = "navbar-nav",
          # li(
          #   class = "nav-item active m-1",
          #   a(class = "nav-link", href = "/#!/shinyace", h4("shinyAce"))
          # ),q1
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/login", h4("Log In"))
          ),
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/signup", h4("Sign Up"))
          ),
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/settings", h4("Settings"))
          ),
          div(
            class = 'nav-item active m-1',
            ui_logout()
          )
        )
      )
    )
  )
}

#' server_navbar
#' @export
server_navbar <- function(id = "navbar", navbarId = "navbarNav") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$collapse, {
        print(reactiveValuesToList(input))
        id <- paste0("#", ns(navbarId))
        toggle(id)
      })
    }
  )
}
