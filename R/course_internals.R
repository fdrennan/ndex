#' course_lesson_html
#' @export
course_lesson_html <- function(lesson_title = "Build or Buy?", heading_padding = "p-1") {
  div(
    class = "row fade-in-text",
    div(
      class = heading_padding,
      h5(
        class = "display-5 text-center",
        lesson_title
      ),
      p(
        class = "lead",
        "Thanks for visiting - this site is under development.",
        "At any point the site may shut off, be disabled temporarily, or look buggy.",
        "But you know, that's kind of interesting right?",
        "Let's start there."
      )
    )
  )
}

#' under_construction
#' @export
under_construction <- function(display_editor = FALSE, code = "") {
  list(
    code = code,
    lesson_html = course_lesson_html(),
    display_editor = display_editor
  )
}

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals <- function(page) {
  switch(as.character(abs(page)),
    "1" = under_construction(),
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
