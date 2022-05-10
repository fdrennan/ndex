#' send_email
#' @export
send_email <- function(user.name = "", passwd = "", to = "", send = FALSE) {

  # library(mailR)
  # library(rJava)
  # Install Java
  # https://www.oracle.com/java/technologies/downloads/#jdk17-windows
  # Allow "less secure apps" from gmail, there is a menu with the same name
  # https://myaccount.google.com/security
  # https://www.r-bloggers.com/2018/02/installing-rjava-on-ubuntu/


  send.mail(
    from = user.name,
    to = to,
    subject = "Hello from R",
    body = "This message was \nsent from R",
    smtp = list(
      host.name = "smtp.gmail.com", port = 465,
      user.name = user.name,
      passwd = passwd,
      ssl = TRUE
    ),
    authenticate = TRUE,
    send = send
  )
}

send_email()