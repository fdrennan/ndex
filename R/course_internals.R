#' lesson_intro
#' @export
lesson_intro <- function() {
  list(
    code = "print('hello!')",
    lesson_html = div(
      class = "p-2",
      h5(
        class = "display-5 text-center",
        "Welcome!"
      ),
      p(
        class = "lead",
        "Thanks for visiting.", "This is a site built",
        "primarily with Plumber and Shiny - two frameworks",
        "built with the R language.", "I have been perfecting",
        "this site and the overall structure for the course for",
        "a few years now and I think the foundation is becoming more concrete."
      ),
      p(
        "Sounds nice - but I really have no idea what I'm doing.",
        "It's a phrase I think many resonate with.",
        "I'm a really ADHD person, and I think I'm a little self-conscious about it.",
        "I worry that my writing switches 'context' quickly, that my English teacher in High School would give me a C+ on my report."
      ),
      p(
        "So I'm going to confidently break out of that shell and just purge my developer tendencies upon you.",
        "I think what this means is that, I will write without worrying about whether or not things are accurate in the short term - because there is a lesson in that.",
        "The lesson is that generally speaking, I primarily program with intention but I rarely write it down.", "I am a very good programmer,",
        "and this comes with some advantages for you.", ""
      ),
      p(
        "If you want to develop applications you have total control over, you need to have an application that is well built that you understand.",
        "I just so happen to have an application I understand - the one you are reading this on."
      )
    ),
    display_editor = FALSE
  )
}

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals <- function(page) {
  switch(page,
    "1" = lesson_intro(),
    "2" = {
      list(
        code = "",
        lesson_html = div(
          h5(
            class = "display-5 text-center",
            "... but things are under construction"
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
    "3" = {
      list(
        code = "library(tidyverse)\nn_unique <- map_dbl(mtcars, n_distinct)",
        lesson_html = withTags(
          div(
            class = "p-2",
            h4("Interface Orientation", class = "display-4 text-center"),
            h5("Moving around using hjkl"),
            p(
              "Take note of what the", code("h"), ",", code("j"), ",", code("k"), ",", "and", code("l"), "keys do.",
              "If you are unfamiliar with", a(href = "https://www.vim.org/about.php", "Vim", target = "_blank"),
              ", I hope you will give it a chance. People often joke about it being 'hard' to learn, but I think once you do",
              "you wont tell me that you regret learning it.",
              "However - if it's not your style - you can go into the settings panel", icon("user", class = "p-1"), "and uncheck ", mark("Use Vim"), "."
            ),
            p(
              "Once you feel familiar with", code("h"), ",", code("j"), ",", code("k"), ",", "and", code("l"),
              "use them to navigate to the", code("4"), "in the function", code("multiply_times_two"), ".",
              "Once you are hovered over it, push the letter", code("r"), "and then the number", code("5"), ".",
              "Note how you can now navigate and replace text and the output will update automatically."
            ),
            dl(
              class = "row p-3",
              dt(
                class = "col-sm-3", "Movement"
              ),
              dd(class = "col-sm-9", "Simple Movement"),
              dt(
                class = "col-sm-3", code("h")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor left")
              ),
              dt(
                class = "col-sm-3", code("j")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor down")
              ),
              dt(
                class = "col-sm-3", code("k")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor up")
              ),
              dt(
                class = "col-sm-3", code("l")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor right")
              ),
              dt(
                class = "col-sm-3", code("3h")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor left three")
              ),
              dt(
                class = "col-sm-3", code("[n][hjkl]")
              ),
              dd(
                class = "col-sm-9",
                p("move cursor", code("[n]"), "times in direction", code("[hjkl]"))
              )
            ),
            h6("Go ahead and practice what was discussed here - ")
          )
        ),
        display_editor = TRUE
      )
    },
    list(
      code = "",
      lesson_html = div("Under Construction"),
      display_editor = FALSE
    )
  )
}
