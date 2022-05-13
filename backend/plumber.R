#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(ndexback)

#* @filter cors
cors <- function(req, res) {

  res$setHeader("Access-Control-Allow-Origin", "*")

  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods","*")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    res$status <- 200
    return(list())
  } else {
    plumber::forward()
  }

}

#* @apiTitle Plumber Example API
#* @apiDescription Plumber example description.


#* Cookie Exchange
#* @serializer json
#* @get /user/login
function(req, res, user='user', password='password') {

  session_id <- req$cookies$session_id
  if (!is.null(session_id)) {
    message('Using existing session id')
    glue('Session {session_id}')
  } else {
    # Create New Session
    message('Create a new session_id')
    session_id <-  UUIDgenerate()
  }

  res$setCookie('session_id', session_id)

  list(session_id = session_id)
}

#* Cookie Exchange
#* @serializer json
#* @get /user/logout
function(req, res) {

  session_id <- req$cookies$session_id
  res$removeCookie('session_id')
  list(
    session_id = session_id
  )
}


#* Echo back the input
#* @param code Code to execute
#* @get /code/markdown
#* @serializer html
function(code = "print(mtcars)") {
  eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", code, "\n```\n")
  ace_envir <- environment()

  # browser()
  tfout <- tempfile()
  tmp <- paste0(tfout, ".html")
  file <- knitr::knit2html(
    text = eval_code,
    # output = tmp,
    fragment.only = TRUE,
    quiet = FALSE,
    envir = ace_envir
  )
  tf <- tempfile()
  fileConn <- file(tf)
  writeLines(file, fileConn)
  close(fileConn)
  readBin(tf, "raw", n = file.info(tf)$size)
}


# Programmatically alter your API
#* @plumber
function(pr) {
  pr %>%
    # Overwrite the default serializer to return unboxed JSON
    pr_set_serializer(serializer_unboxed_json())
}
