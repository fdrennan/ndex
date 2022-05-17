#' ui_get_inside
#' @export
ui_get_inside <- function(id = "get_inside", title = "Sign Up") {
  ns <- NS(id)
  div(
    class = "row m-1",
    div(class = "col-lg-3"),
    div(
      class = "col-lg-6 well bg-light p-1",
      div(class = "p-5", wellPanel(
        h3(title, class = "text-center"),
        textInput(ns("email"), "Email"),
        passwordInput(ns("password"), "Password"),
        actionButton(ns("submit"), "Submit", class = "btn btn-primary float-end my-2")
      ))
    )
  )
}

#' server_get_inside
#' @export
server_get_inside <- function(id = "get_inside", login = FALSE) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      iv <- InputValidator$new(session = session)
      # iv$add_rule(ns("user"), sv_required())
      iv$add_rule("password", sv_required())
      iv$add_rule("email", sv_required())
      iv$add_rule("email", sv_email())
      iv$enable()

      observeEvent(input$submit, {
        if (iv$is_valid()) {
          email <- input$email
          password <- input$password
          # browser()
          resp <- "https://ndexr.com/api/user/create?email={email}&password={password}"
          resp <- GET(resp)
          if (fromJSON(content(resp, "text"))$authorized) {
            change_page("home")
          } else {
            showNotification("Please try again.")
          }
        } else {
          showNotification("Please enter all required information")
        }
      })
    }
  )
}
