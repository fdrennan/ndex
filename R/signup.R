#' ui_signup
#' @export
ui_signup <- function(id='signup') {

  js_code <- 'shinyjs.getcookie = function(params) {
                  var cookie = Cookies.get("id");
                  if (typeof cookie !== "undefined") {
                    Shiny.onInputChange("jscookie", cookie);
                  } else {
                    var cookie = "";
                    Shiny.onInputChange("jscookie", cookie);
                  }
                }

              shinyjs.setcookie = function(params) {
                  /* expires after 12 hours  */
                  Cookies.set("id", escape(params), { expires: 0.5 });
                  Shiny.onInputChange("jscookie", params);
              }
              shinyjs.rmcookie = function(params) {
                  Cookies.remove("id");
                  Shiny.onInputChange("jscookie", "");
              }'
  ns <- NS(id)
  div(class='row',
      extendShinyjs(js_code, functions=c('setcookie', 'rmcookie', 'getcookie')),
      div(class='col-lg-3'),
      div(class='col-lg-6 well bg-light p-1',
          div(class='p-5', wellPanel(
            h3('Sign Up', class='text-center'),
            textInput(ns('email'), 'Email'),
            passwordInput(ns('password'), 'Password'),
            actionButton(ns('submit'), 'Submit', class='btn btn-primary float-end my-2')
          ))
  ))
}

#' server_signup
#' @export
server_signup <- function(id='signup') {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      iv <- InputValidator$new(session = session)
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
        #
        session$sendCustomMessage("cookie-set", list(
          name = "session_id", value = session_id
        ))
        showNotification('Welcome...')
        js$setcookie(session_id)
        change_page('home', session)
      })
    }
  )
}
