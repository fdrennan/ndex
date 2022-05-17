course_internals <- function(page) {
  switch(page,
    "1" = {
      list(
        code = "print('hello!')",
        lesson_html = p(
          "Thanks for visiting!"
        )
      )
    },
    "2" = {
      list(
        code = "library(tidyverse)\nhead(mtcars, 5)",
        lesson_html = p(
          "This is an interactive console.",
          "As you move about the course, you can choose to interact or not with the code."
        )
      )
    },
    "3" = {
      list(
        code = "library(tidyverse)\nhead(mtcars)",
        lesson_html = p("This is nice because you can tweak the code provided.")
      )
    }
  )
}
