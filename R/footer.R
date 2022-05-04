#' ui_footer
#' @export
ui_footer <- function(id = "footer") {
  ns <- NS(id)
  tags$footer(
    class = "bg-dark text-center text-white",
    # ui_contact(),
    div(
      ui_contact_us(),
      class = "container p-2",
      ui_social_links(),
      other_links(),
      div(
        class = "text-center p-3",
        "© 2020 Copyright:",
        tags$a(class = "text-white", href = "https://ndexr.com", "ndexr")
      )
    )
  )
}

#' server_footer
#' @export
server_footer <- function(id = "footer") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observe({
        isolate(input$email)
        email <- input$email
        # isolate(email)
        print(email)
      })
      iv <- InputValidator$new()
      iv$add_rule("email", sv_email())
      iv$enable()
      # observe(print(input))
    }
  )
}
