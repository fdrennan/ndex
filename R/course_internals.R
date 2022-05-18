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
        lesson_html = div(
          p(
            class = "lead",
            "This is an interactive console.",
            "As you move about the course, you can choose to interact or not with the code.",
            "If you have used something like DataCamp before, I want to make this something similar but not quite."
          ),
          p("I'm not going to hide solutions. We are going to build applications like this one, and I am going to tell you exactly what to do in order to be successful.")
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
