#' ui_login
#' @export
ui_login <- function(id='signup') {
  ns <- NS(id)
  fluidRow(
    div(class='col-lg-4'),
    div(class='col-lg-4 well bg-light m-4',
        div(class='p-5', wellPanel(
          div(
            class='form-group',
            textInput(ns('email'), 'Email'),
            passwordInput(ns('password_new'), 'Password'),
            actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
          )
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
        req(iv$is_valid())
        con <- connect_table()
        on.exit(dbDisconnect(con))
        change_page('home', session)
      })
    }
  )
}
