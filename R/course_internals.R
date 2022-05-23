

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals <- function(page) {
  switch(as.character(abs(page)),
    "1" = list(
      lesson_html = div(
        class = "row",
        div(
          class = 'p-1',
          h5(
            class = "display-5 text-center",
            'Build or Buy'
          ),
          p(
            class = "lead fade-in-text",
            div(class='text-center',
              "Thanks for visiting - this site is under development.",
              "Please step through the next few slides to get oriented."
            )
          )
        )
      ),
      code = '',
      display_editor = FALSE
    ),
    "2" = list(
      header = h5('Orientation', class='display-5 text-center p-2'),
      lesson_html = div(
        class = "row",
        div(
          class = 'p-1',
          h5('On Building Applications', class='text-center'),
          p(class='lead', 'Building software is hard. Writing sentences is harder.',
            'But here I am, figuring it out.',"When writing software, figuring it out is the goal.",
            "Many think that software development is leetcode and algorithms, but I'd argue that it's much more intuitive.",
            "Applications are mysteries to be unraveled and explored and tested.",
            "You build applications iteratively, while constantly abstracting.",
            "The more talented you are, the more abstractly you start your project.",
            "For example, do you use a file watcher or aliases?",
            "Does your project have a Makefile, Dockerfile, .gitignore?",
            "What does the .Rprofile or .Renviron file do? Should I use them?")
        )
      ),
      code = '',
      display_editor = FALSE
    ),
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
