#' make_page
#' @export
make_page <- function(header = div("Nothing Here"), lesson_html = div(), code = "print(\"Hello, world!\")", display_editor = FALSE) {
  list(
    header = header,
    code = code,
    lesson_html = lesson_html,
    display_editor = display_editor
  )
}

#' purrr_page_one
#' @export
purrr_page_one <- function() {
  list(
    header = div(
      h5(class = "display-5 text-center", "purrr")
    ),
    code = "library(purrr)\nmap_dbl(1:3, function(x) x * 2)",
    lesson_html = withTags(
      div(
        p("R is a functional language.", "And", mark("purrr"), "is a library for functional programming...")
      )
    ),
    display_editor = TRUE
  )
}

#' course_purrr
#' @export
course_purrr <- function(page) {
  switch(as.character(abs(page)),
    "1" = purrr_page_one(),
    make_page()
  )
}
