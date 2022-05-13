#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(ndexback)

#* @apiTitle Plumber Example API
#* @apiDescription Plumber example description.


#* @filter cors
function(req, res) {

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



#* Log some information about the incoming request
#* @filter logger
function(req){
  cat(as.character(Sys.time()), "-",
      req$REQUEST_METHOD, req$PATH_INFO, "-",
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}


#* Create new user
#* @serializer json
#* @get /user/create
function(req, res, email, hash, phone_number = '', time_zone = '') {
  res$removeCookie('session_id')

  # Create data to add user
  user_info <- data.frame(
    email = email,
    hash = hash,
    created = Sys.time(),
    role = 'user',
    id = UUIDgenerate(),
    phone_number = phone_number,
    time_zone = time_zone
  )

  con <- connect_table('lite', 'sqlite.db')
  on.exit(dbDisconnect(con))
  # browser()
  if (isFALSE(dbExistsTable(con, 'users'))) {
    dbCreateTable(con, 'users', user_info)
  } else {
    message("Checking that user doesn't exist.")
    users <- tbl(con, 'users') %>% filter(email %in% local(email)) %>% collect
    stopifnot(nrow(users)==0)
  }

  dbAppendTable(con, 'users', user_info)

  session_id <- UUIDgenerate()
  session <- data.frame(
    email = email,
    session_id = session_id,
    logged_id = TRUE,
    created = Sys.time()
  )

  if (isFALSE(dbExistsTable(con, 'sessions'))) {
    dbCreateTable(con, 'sessions', session)
  }

  dbAppendTable(con, 'sessions', session)

  res$setCookie('session_id', session_id)
  res$status <- 303 # redirect
  res$setHeader("Location", glue(
    "https://ndexr.com/#!/home?session_id={session_id}"
  ))
  list(session_id = session_id)
}

#* Login as existing user
#* @serializer json
#* @get /user/login
function(req, res, email, hash) {
  res$removeCookie('session_id')
  con <- connect_table('lite', 'sqlite.db')
  on.exit(dbDisconnect(con))

  users <- tbl(con, 'users') %>% filter(email %in% local(email)) %>% collect
  stopifnot(nrow(users)==1)

  res$status <- 303 # redirect
  if(users$hash==hash) {
    res$setCookie('session_id', session_id)
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/home?session_id={session_id}"
    ))
  } else {
    res$removeCookie('session_id')
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/login"
    ))
  }
}



#* Cookie Exchange
#* @serializer json
#* @get /user/logout
function(req, res) {

  session_id <- req$cookies$session_id
  res$removeCookie('session_id')
  res$status <- 303 # redirect
  res$setHeader("Location", "https://ndexr.com/#!/login")
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
