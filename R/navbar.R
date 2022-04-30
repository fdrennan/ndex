#' ui_navbar
#' @export
ui_navbar <- function(id = "navbar", navbarId = "navbarNav") {
  ns <- NS(id)
  id <- ns("navbarNav")
  id_hash <- paste0("#", id)
  withTags(
    nav(
      class = "navbar navbar-expand-lg navbar-dark bg-dark",
      a(class = "navbar-brand", href = "/#!/", h4("Home")),
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
        class = "collapse navbar-collapse",
        id = id,
        ul(
          class = "navbar-nav mr-auto",
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/about", h4("About"))
          ),
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/theme", h4("Theme"))
          ),
          li(
            class = "nav-item active",
            a(class = "nav-link", href = "/#!/settings", h4("Settings"))
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
