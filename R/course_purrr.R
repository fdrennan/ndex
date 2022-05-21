#' course_purrr
#' @export
course_purrr <- function(page) {
  switch(as.character(abs(page)),
    "1" = {
      list(
        header = div(
          h5(class = "display-5 text-center", "purrr")
        ),
        code = "library(purrr)\nlibrary(dplyr)\n\nmap_dbl(1:3, function(x) x * 2)\nmap_chr(1:3, function(x) paste0('id-', x))",
        lesson_html = withTags(
          div(
            p('R is a functional language.', "And", mark("purrr"), "is a library for functional programming...",
              "So, I suppose we need to define what a function is.", 'A function is a thing that takes something or nothing and returns something or nothing.',
              'A function that returns nothing is often called for side-effects like printing to the screen, or saving something to disk.',
              'Functions which take something and return something else are the most common.'),
            p('In the example to the right, ')
          )
        ),
        display_editor = TRUE
      )
    },
    "2" = {
      list(
        header = div(),
        code = "",
        lesson_html = tags$pre(
          map(
            c('function(x) x', '~ ..1', '~ .x + .y'),
            function(x) {
              tags$code(x)
            }
          )
        ),
        display_editor = FALSE
      )
    },
    list(
      code = "",
      lesson_html = div("well this is embarrasing."),
      display_editor = FALSE
    )
  )
}
