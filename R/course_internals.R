

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' #TODO Set this up to read a pre-specified directory
#' @export
course_internals <- function(page, course, config) {
  course_config <- keep(config, ~ .$name == course)

  course_pages <- dir_ls(first(course_config)$directory, regexp = "[.]html")

  if (length(page) < 10) {
    page <- paste0("0", page)
  }

  page <- course_pages[str_detect(course_pages, page)]

  if (!length(page)) {
    list(
      lesson_html = h5("Nothing Here", class = "display-5"),
      code = "#todo",
      display_editor = FALSE
    )
  } else {
    list(
      lesson_html = div(
        class = "container",
        HTML(read_file(page))
      ),
      code = "#todo",
      display_editor = TRUE
    )
  }
}
