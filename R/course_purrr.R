#' course_purrr
#' @export
course_purrr <- function(page) {
  switch(as.character(abs(page)),
    "1" = {
      list(
        code = "",
        lesson_html = div(
          h5(
            class = "display-5 text-center",
            "purrr"
          ),
          p(
            class = "p-2",
            "R is a functional language."
          )
        ),
        display_editor = FALSE
      )
    },
    list(
      code = "library(purrr)\nmap_dfc(iris, length)",
      lesson_html = div("A mapping function..."),
      display_editor = TRUE
    )
  )
}
