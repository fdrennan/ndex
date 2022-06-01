#' ui_login
#' @export
ui_login <- function(id = "login", title = "Sign Up") {
  ns <- NS(id)
  div(
    id = ns(id),
    useShinyjs(),
    class = "row",
    div(class = "col-xl-4 col-lg-3 col-md-3"),
    div(
      class = "col-xl-4 col-lg-6 col-md-6 well bg-light p-1",
      div(class = "p-5", wellPanel(
        h3(title, class = "text-center"),
        textInput(ns("email"), "Email"),
        passwordInput(ns("password"), "Password"),
        actionButton(ns("submit"), "Submit", class = "btn btn-primary float-end my-2")
      ))
    )
  )
}

#' server_login
#' @export
server_login <- function(id = "login", logged_in = TRUE) {
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

      out <- eventReactive(input$submit, {
        if (iv$is_valid()) {
          email <- input$email
          password <- input$password
          resp <- glue("https://ndexr.com/api/user/create?email={email}&password={password}")
          resp <- GET(resp)
          is_authorized <- fromJSON(content(resp, "text"))$authorized
          if (is_authorized) {
            authorized <- TRUE
            change_page("home")
          } else {
            showNotification("Please try again.")
            authorized <- FALSE
          }
        } else {
          showNotification("Please enter all required information")
          authorized <- FALSE
          email <- NA
        }

        iv <- InputValidator$new(session = session)
        iv$add_rule("password", sv_required())
        iv$add_rule("email", sv_required())
        iv$add_rule("email", sv_email())
        iv$enable()

        out <- eventReactive(input$submit, {
          if (iv$is_valid()) {
            email <- input$email
            password <- input$password
            resp <- glue("https://ndexr.com/api/user/create?email={email}&password={password}")
            resp <- GET(resp)
            is_authorized <- fromJSON(content(resp, "text"))$authorized
            if (is_authorized) {
              authorized <- TRUE
              change_page("settings")
            } else {
              showNotification("Please try again.")
              authorized <- FALSE
            }
          } else {
            showNotification("Please enter all required information")
            authorized <- FALSE
            email <- NA
          }

          user_data <- list(authorized = authorized, email = email)

          user_data
        })
      })

      out
    }
  )
}
