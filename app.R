library(ndex)
library(shinyjs)
dotenv::load_dot_env()
# system('/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css')

#' ui_navbar
#' @export
ui_navbar <- function(id='navbar',navbarId='navbarNav') {
  ns <- NS(id)
  # id <- ns("navbarToggleExternalContent")

  id <- ns("navbarNav")
  id_hash <- paste0('#', id)
  withTags(
    nav(
      class='navbar navbar-expand-lg navbar-light bg-light',
      a(class='navbar-brand', href='#', 'Navbar'),
      button(d = ns("collapse"),
             class = "navbar-toggler action-button",
             type = "button",
             `data-bs-toggle` = "collapse",
             `data-bs-target` = paste0('#',id),
             `aria-controls` = id,
             `aria-expanded` = "false",
             `aria-label` = "Toggle navigation",
             span(class = "navbar-toggler-icon")
      ),
      div(
        class="collapse navbar-collapse",
        id=id,
        ul(class='navbar-nav mr-auto',
           li(
             class='nav-item active',
             a(class='nav-link', href='#', 'Home')
           ),
           li(
             class='nav-item active',
             a(class='nav-link', href='#', 'Link')
           ))
      ),
      # div(class='pos-f-t',
      #   div(
      #     class = "collapse", id = id,
      #     div(class='bg-dark p-4',
      #       h4(class = "text-white h4", "Collapsed Content"),
      #       span(class = "text-muted", "Toggleable via the navbar brand")
      #     )
      #   ),
      #   tags$nav(
      #     class = "navbar navbar-dark bg-dark",
      #     div(
      #       class = "container-fluid",
      #       tags$button(id = ns("collapse"), class = "navbar-toggler action-button", type = "button", `data-bs-toggle` = "collapse", `data-bs-target` = paste0('#',id), `aria-controls` = id, `aria-expanded` = "false", `aria-label` = "Toggle navigation",
      #                   span(class = "navbar-toggler-icon"))
      #     ),
      #
      #   )
      # )
    )
  )
}

#' server_navbar
#' @export
server_navbar <- function(id='navbar', navbarId='navbarNav') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$collapse, {
        print(reactiveValuesToList(input))
        id <- paste0('#',ns(navbarId))
        toggle(id)
      })
    }
  )
}

#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    bs_text_ui()
  )
}



#' server
#' @export
server <- function(input, output, session) {
  server_navbar()
}

shinyApp(
  ui = ui,
  server = server
)
