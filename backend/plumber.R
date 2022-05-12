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

#* Echo back the input
#* @param code Code to execute
#* @get /code/rmarkdown
#* @serializer html
function(code = "print(mtcars)") {
  prefix <- '---
title: ""
output:
html_document:
  toc: yes
---
```{r}'
  postfix <- "```"
  #
  code <- paste0(c(prefix, code, postfix), collapse = "\n")
  tf <- tempfile()
  tfout <- tempfile()
  fileConn <- file(tf)
  writeLines(code, fileConn)
  close(fileConn)
  render(tf, output_file = tfout, output_format = "html_document")
  tmp <- paste0(tfout, ".html")
  readBin(tmp, "raw", n = file.info(tmp)$size)
}

#* Echo back the input
#* @param code Code to execute
#* @get /code/markdown
#* @serializer html
function(code = "print(mtcars)") {
  eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", code, "\n```\n")
  ace_envir <- environment()

  #
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

#* Plot a histogram
#* @serializer json
#* @get /email
function(from, passwd, to = "<fr904103@bmrn.com>", subject = "test", body = "This was sent from R", smtpServer = "mail.bmrn.com") {
  # library(mailR)
  # library(rJava)
  # Install Java
  # https://www.oracle.com/java/technologies/downloads/#jdk17-windows
  # Allow "less secure apps"
  # https://myaccount.google.com/security

  # Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-17.0.2/")

  # from <- sprintf("<fr904103@bmrn.com>","Freddy Drennan") # the sender’s name is an optional value
  # to <- c("<fr904103@bmrn.com>", "<cheng.su@bmrn.com>")
  # subject <- "Email test within Docker on HPC"
  # body <- "Test Was Successful"

  sendmail(front, to, subject, body, control = list(smtpServer = smtpServer))

  toJSON(TRUE)
}

# Programmatically alter your API
#* @plumber
function(pr) {
  pr %>%
    # Overwrite the default serializer to return unboxed JSON
    pr_set_serializer(serializer_unboxed_json())
}
