#' ui_signup
#' @export
ui_signup <- function(id='signup') {
  ns <- NS(id)
  div(class='row',
      div(class='col-lg-4'),
      div(class='col-lg-4 well bg-light m-4',
          div(class='p-1',
              h4('Sign Up', class='text-center'),
              map(
                list(
                  textInput(ns('user'), 'Username'),
                  passwordInput(ns('password'), 'Password'),
                  textInput(ns('email'), 'Email'),
                  actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
                ),
                function(val) {
                  div(val, class='p-1')
                }
              )
          )
      )
  )
}

#' server_signup
#' @export
server_signup <- function(id='signup') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      iv <- InputValidator$new()
      iv$add_rule("user", sv_required())
      iv$add_rule("password", sv_required())
      iv$add_rule("email", sv_required())
      iv$add_rule("email", sv_email())
      iv$enable()

      observeEvent(input$submit, {
        req(iv$is_valid())
        con <- connect_table()
        on.exit(dbDisconnect(con))
        session_id <- UUIDgenerate()
        login_creds <- data.frame(
          user = input$user,
          email = input$email,
          password = input$password,
          created_time = Sys.time(),
          session_id = session_id,
          role = 'admin'
        )
        if (!dbExistsTable(con, 'users')) {
          dbCreateTable(con, 'users', login_creds)
        }
        dbAppendTable(con, 'users', login_creds)
        # browser()
        session$sendCustomMessage("cookie-set", list(
          name = "session_id", value = session_id
        ))
        showNotification('Welcome...')
        change_page('home', session)
      })
    }
  )
}
