

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals <- function(page) {
  switch(as.character(page),
    "1" = list(
      lesson_html = HTML(markdown::markdownToHTML('courses/r-app/01_prereq.md', fragment.only = T)),
      code = "",
      display_editor = FALSE
    ),
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
