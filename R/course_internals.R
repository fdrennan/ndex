

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' #TODO Set this up to read a pre-specified directory
#' @export
course_internals <- function(page) {
  switch(as.character(page),
    "1" = list(
      lesson_html = HTML(markdown::markdownToHTML('courses/r-app/01_prereq.md', fragment.only = T)),
      code = read_file('courses/r-app/01_prereq.R'),
      display_editor = TRUE
    ),
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
