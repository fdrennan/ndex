#' ui_login
#' @export
ui_login <- function(id='signup') {
  ns <- NS(id)
  fluidRow(
    div(class='col-lg-3'),
    div(class='col-lg-6 well bg-light p-1',
        div(class='p-5', wellPanel(
          h3('Log In', class='text-center'),
          textInput(ns('email_new'), 'Email'),
          passwordInput(ns('password_new'), 'Password'),
          actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
        ))
  ))
}

#' server_login
#' @export
server_login <- function(id='signup') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observeEvent(input$submit, {
        # req(iv$is_valid())
        con <- connect_table()
        on.exit(dbDisconnect(con))
        change_page('home', session)
      })
    }
  )
}
