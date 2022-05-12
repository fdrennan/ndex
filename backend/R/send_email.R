

#' send_email
#' @export
#* Plot a histogram
send_email <- function(
  from,
  passwd,
  to = "<fr904103@bmrn.com>",
  subject = "test", body = "This was sent from R", smtpServer = "mail.bmrn.com"
) {
  sendmail(front, to, subject, body, control = list(smtpServer = smtpServer))

  toJSON(TRUE)
  # https://localcoder.org/sending-an-email-from-r-using-the-sendmailr-packages
}
