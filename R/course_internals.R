course_internals <- function(page) {
  switch(page,
    "1" = {
      list(
        code = "library(tidyverse)",
        lesson_html = p(
          "Welcome, I'm excited to share my passion for R with you!"
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
