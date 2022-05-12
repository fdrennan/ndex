#' ui_login
#' @export
ui_login <- function(id='signup') {
  ns <- NS(id)
  div(
    class='back',
    div(
      class='div-center',
      div(
        class='content',
        h4('Log In', class='text-center'),
        tags$form(div(
          class='form-group',
          textInput(ns('email'), 'Email'),
          passwordInput(ns('password'), 'Password'),
          actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
        ))
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
      iv <- InputValidator$new()
      iv$add_rule("email", sv_required())
      iv$add_rule("password", sv_required())
      iv$enable()

      observeEvent(input$submit, {
        req(iv$is_valid())
        con <- connect_table()
        on.exit(dbDisconnect(con))
        change_page('home', session)
      })
    }
  )
}
