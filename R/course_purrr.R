#' course_purrr
#' @export
course_purrr <- function(page) {
  switch(as.character(abs(page)),
    "1" = {
      list(
        header = div(
          h5(class = "display-5 text-center", "purrr")
        ),
        code = "library(purrr)\nlibrary(dplyr)\nmap(iris, n_distinct)\nmap_dbl(iris, n_distinct)",
        lesson_html = withTags(
          p('R is a functional language.', "And", mark("purrr"), "is a library for functional programming...")
        ),
        display_editor = TRUE
      )
    },
    list(
      code = "",
      lesson_html = div("well this is embarrasing."),
      display_editor = FALSE
    )
  )
}
