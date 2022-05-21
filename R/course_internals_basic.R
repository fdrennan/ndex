#' course_internals_basic
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals_basic <- function(page) {
  switch(as.character(abs(page)),
    "1" = {
      list(
        code = "",
        lesson_html = div(
          h5(
            class = "display-5 text-center",
            "under construction"
          ),
          p(
            class = "p-2",
            "Please note that as the site currently stands, there is no guarantee that your current",
            "progress or even login credentials will remain.", "This site is heavily under construction and what follows is a course under development."
          )
        ),
        display_editor = FALSE
      )
    },
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
