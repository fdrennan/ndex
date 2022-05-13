#' ui_signup
#' @export
ui_signup <- function(id='signup') {

  ns <- NS(id)
  div(class='row',
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
      # iv$add_rule(ns("user"), sv_required())
      iv$add_rule("password", sv_required())
      iv$add_rule("email", sv_required())
      iv$add_rule("email", sv_email())
      iv$enable()

      observeEvent(input$submit, {
        # browser()
        if (iv$is_valid()){
          shinyjs::runjs(paste0('window.location.href = "https://ndexr.com/api/user/login";'))
        } else {
          showNotification('Please enter all required information')
        }
        # change_page('https://ndexr.com/api/user/login', session)
      })
    }
  )
}
