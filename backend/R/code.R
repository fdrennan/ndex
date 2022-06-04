
#' code_markdown
#' @export
code_markdown <- function(code = "print(mtcars)") {
  eval_code <- paste0("\n```{r echo = TRUE, comment = NA}\n", code, "\n```\n")
  ace_envir <- environment()

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

#' code_course
#' @param lesson
#' @export
code_course <- function(lesson = "./course/R/lesson_1.Rmd") {
  tmp <- tempfile(fileext = ".html")
  path_for_dir <- fs::path_dir(lesson)
  rmarkdown::render(
    input = lesson
    # output_format = 'html',
    # output_dir = path_for_dir,
    # fragment.only = TRUE,
    # quiet = FALSE
    # envir = ace_envir
  )
  path_for_file <- fs::`path_ext<-`(lesson, ".nb.html") %>% unclass()
  readBin(path_for_file, "raw", n = file.info(path_for_file)$size)
}
