#' ui_login
#' @export
ui_login <- function(id='signup') {
  ns <- NS(id)
  div(class='row',
      div(class='col-lg-4'),
      div(class='col-lg-4 well bg-light m-4',
          div(class='p-1',
              h4('Log In', class='text-center'),
              map(
                list(
                  textInput(ns('email'), 'Email'),
                  passwordInput(ns('password'), 'Password')
                ),
                function(val) {
                  div(val, class='p-1')
                }
              ),
              actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
          )
      )
  )
}

#' server_login
#' @export
server_login <- function(id='signup') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$submit, {
        con <- connect_table()
        on.exit(dbDisconnect(con))
        change_page('home', session)
      })
    }
  )
}
