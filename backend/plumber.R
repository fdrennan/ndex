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
#* @serializer png
#* @get /sendemail
function() {
  send_email()
  # TRUE
}


# Programmatically alter your API
#* @plumber
function(pr) {
  pr %>%
    # Overwrite the default serializer to return unboxed JSON
    pr_set_serializer(serializer_unboxed_json())
}
