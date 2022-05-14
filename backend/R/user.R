#' user_create
#' @export
user_create <- function(req, res, email, password, phone_number = "", time_zone = "") {
  res$removeCookie("session_id")
  hash <- hashpw(password)
  session_id <- UUIDgenerate()
  con <- connect_table("lite", "sqlite.db")
  on.exit(dbDisconnect(con))
  # Create data to add user
  user_info <- data.frame(
    email = email,
    hash = hash,
    created = Sys.time(),
    role = "user",
    phone_number = phone_number,
    time_zone = time_zone
  )

  if (isFALSE(dbExistsTable(con, "users"))) {
    dbCreateTable(con, "users", user_info)
  }
  message("Checking that user doesn't exist.")
  users <- tbl(con, "users") %>%
    filter(email %in% local(email)) %>%
    collect()

  res$status <- 303


  if (nrow(users) == 1) {
    IS_AUTH <- bcrypt::checkpw(password, users$hash)
    if (!IS_AUTH) {
      res$removeCookie("session_id")
      res$setHeader("Location", glue(
        "https://ndexr.com/#!/get_inside?tryagain=TRUE"
      ))
    } else {
      res$setCookie("session_id", session_id)
      res$setHeader("Location", glue(
        "https://ndexr.com/#!/home?session_id={session_id}"
      ))
    }
  } else {
    dbAppendTable(con, "users", user_info)
    res$setCookie("session_id", session_id)
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/home?session_id={session_id}"
    ))
  }
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
    res$setCookie("session_id", session_id)
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/home?session_id={session_id}"
    ))
  } else {
    res$removeCookie("session_id")
    res$setHeader("Location", glue(
      "https://ndexr.com/#!/get_inside"
    ))
  }
  list(session_id = session_id)
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
