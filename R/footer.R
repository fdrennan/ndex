#' ui_footer
#' @export
ui_footer <- function(id = "footer") {
  ns <- NS(id)
  tags$footer(
    class = "bg-dark text-center text-white",
    # ui_contact(),
    div(
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
                          input(
                            type = "text", class = "form-control", placeholder = "Email",
                            `aria-label` = "Recipient's name", `aria-describedby` = "button-addon2",
                          )
                        ),
                        div(
                          class = "input-group-append my-auto",
                          button(class = "btn btn-success", type = "button", id = "button-addon1", b("Submit"))
                        )
                      )
                    )
                  )
                )
              ))
            )
          )
        )
      ),
      class = "container p-2",
      ui_social_links(),
      withTags(
        section(
          div(
            class = "row",
            div(
              class = "col-lg-6 col-md-6 my-4 mb-md-0",
              ul(
                class = "list-unstyled mb-0",
                h5(class = "text-uppercase", "Useful Resources"),
                li(a(
                  href = "https://hackerthemes.com/bootstrap-cheatsheet/", class = "text-white", "Bootstrap Cheatsheet"
                ))
              )
            ),
            div(
              class = "col-lg-6 col-md-6 mb-4 mb-md-0",
              ul(
                class = "list-unstyled mb-0",
                h5(class = "text-uppercase", "Development"),
                li(a(
                  href = "https://ndexr.com/youtrack", class = "text-white", "YouTrack"
                ))
              )
            )
          )
        )
      ),
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
      # server_contact()
      # observe(print(input))
    }
  )
}
