#' user_create
#' @export
user_create <- function(req, res, email, password, phone_number = "", time_zone = "") {
  print(email)
  print(password)
  con <- connect_table("lite", "sqlite.db")
  on.exit(dbDisconnect(con))

  # Create data to add user
  user_info <- data.frame(
    email        = email,
    hash         = hashpw(password),
    created      = Sys.time(),
    role         = "user",
    phone_number = phone_number,
    time_zone    = time_zone
  )

  if (isFALSE(dbExistsTable(con, "users"))) {
    message("Creating users table")
    dbCreateTable(con, "users", user_info)
    message("First table, user created and access granted.")
    dbAppendTable(con, "users", user_info)
  }

  users <- tbl(con, "users") %>%
    filter(email %in% local(email)) %>%
    collect()

  out <- list()
  if (!email %in% users$email) {
    message("First table, user created and access granted.")
    dbAppendTable(con, "users", user_info)
    out$authorized <- TRUE
  } else {
    if (!bcrypt::checkpw(password, users$hash)) {
      message("Password unauthorized")
      out$authorized <- FALSE
    } else {
      message("Password authorized")
      out$authorized <- TRUE
    }
  }

  out
}


#' user_logout
#' @export
user_logout <- function(req, res) {
  session_id <- req$cookies$session_id
  res$removeCookie("session_id")
  res$status <- 303 # redirect
  res$setHeader("Location", "https://ndexr.com/#!/get_inside")
  list(
    session_id = session_id
  )
}
