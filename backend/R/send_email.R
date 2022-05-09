#' send_email
#'@export
send_email <- function() {

  library(mailR)
  library(rJava)
  # Install Java
  # https://www.oracle.com/java/technologies/downloads/#jdk17-windows
  # Allow "less secure apps" from gmail, there is a menu with the same name
  # https://myaccount.google.com/security
  # https://www.r-bloggers.com/2018/02/installing-rjava-on-ubuntu/


  send.mail(from = "drennanfreddy@gmail.com",
            to = "drennanfreddy@gmail.com",
            subject = "Hello from R",
            body = "This message was \nsent from R",
            smtp = list(host.name = "smtp.gmail.com", port = 465,
                        user.name = "drennanfreddy@gmail.com",
                        passwd = "",
                        ssl = TRUE),
            authenticate = TRUE,
            send = TRUE)



}

send_email()
