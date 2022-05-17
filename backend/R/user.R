#' user_create
#' @export
user_create <- function(req, res, email, password, phone_number = "", time_zone = "") {

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
    dbCreateTable(con, "users", user_info)
    dbAppendTable(con, "users", user_info)
  }

  users <- tbl(con, "users") %>%
    filter(email %in% local(email)) %>%
    collect()

  out <- list()
  if (!bcrypt::checkpw(password, users$hash)) {
    out$authorized <- FALSE
  } else {
    out$authorized <- TRUE
  }
  out
}

#' user_login
#' @export
user_login <- function(req, res, email, password) {
  res$removeCookie("session_id")
  con <- connect_table("lite", "sqlite.db")
  on.exit(dbDisconnect(con))

  users <- tbl(con, "users") %>%
    filter(email %in% local(email)) %>%
    collect()
  user_exists <- nrow(users) == 1
  hash_match <- checkpw(password, users$hash)
  res$status <- 303 # redirect
  session_id <- UUIDgenerate()
  if (all(user_exists, hash_match)) {
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/home?session_id={session_id}"
    ))
  } else {
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/get_inside"
    ))
  }
  plumber::forward()
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
