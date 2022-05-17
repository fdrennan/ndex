#' ui_footer
#' @export
ui_footer <- function(id = "footer") {
  ns <- NS(id)
  uiOutput(ns("footer"))
}

#' server_footer
#' @export
server_footer <- function(id = "footer", settings, credentials) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observe({
        isolate(input$email)
        email <- input$email
        print(email)
      })
      iv <- InputValidator$new()
      iv$add_rule("email", sv_email())
      iv$enable()
      # observe(print(input))

      output$footer <- renderUI({
        req(credentials())
        if (!isTRUE(settings$minimal)) {
          tags$footer(
            class = "bg-dark text-center text-white",
            # ui_contact(),
            div(
              # ui_contact_us(),
              class = "container",
              div(
                class = "py-1",
                ui_social_links()
              ),
              div(
                class = "",
                other_links()
              ),
              div(
                class = "text-center",
                "© 2022 Copyright:",
                tags$a(class = "text-white", href = "https://ndexr.com", "ndexr")
              )
            )
          )
        }
      })
    }
  )
}
