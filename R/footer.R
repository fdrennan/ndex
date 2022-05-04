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
      observe({
        isolate(input$email)
        email <- input$email
        # isolate(email)
        print(email)
      })
      iv <- InputValidator$new()
      iv$add_rule("email", sv_email())
      iv$enable()
      server_contact_us()
      # observe(print(input))
    }
  )
}


#' ui_contact_us
#' @export
ui_contact_us <- function(id='contact_us') {
  ns <- NS(id)
  withTags(
    section(
      withTags(
        div(
          class = "row",
          div(class = "col", div(
            class = "card-border-0",
            div(
              class = "card-body text-center",
              h2(b("Full Stack R Contracting")),
              p(class = "m-1", ""),
              div(
                class = "row text-center justify-content-center",
                div(
                  class = "col-auto",
                  div(
                    class = "input-group-lg input-group m-3",
                    div(
                      class = "m-2 my-auto",
                      textInput(
                        ns('email'), NULL, 'Email'

                        # `aria-label` = "Recipient's name", `aria-describedby` = "button-addon2",
                      )
                    ),
                    div(
                      class = "input-group-append my-auto",
                      actionButton(ns("submit"), class = "btn btn-success", b("Submit"))
                    )
                  )
                )
              )
            )
          ))
        )
      )
    )
  )
}

#' server_contact_us
#' @export
server_contact_us <- function(id='contact_us') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observe({
        # browser()
        print(reactiveValuesToList(input))
      })
    }
  )
}
