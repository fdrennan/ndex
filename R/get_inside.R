#' ui_get_inside
#' @export
ui_get_inside <- function(id = "get_inside", title = "Sign Up") {
  ns <- NS(id)
  div(
    id = ns(id),
    useShinyjs(),
    class = "row m-1",
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

#' server_get_inside
#' @export
server_get_inside <- function(id = "get_inside", logged_in = TRUE) {
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
        if (logged_in) {
          authorized <- TRUE
          email <- "guest@ndexr.com"
          password <- "guest"
        } else {
          iv$is_valid()
          authorized <- TRUE
          email <- input$email
          password <- input$password
        }

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
      })

      out
    }
  )
}
