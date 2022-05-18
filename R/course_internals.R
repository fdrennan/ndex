course_internals <- function(page) {
  switch(page,
    "1" = {
      list(
        code = "print('hello!')",
        lesson_html = div(class='p-2',
          h5(class='display-5 text-center',
             "Welcome!"
          ),
          p("Thanks for visiting.", "This is a site built",
            "primarily with Plumber and Shiny - two frameworks",
            "built with the R language.", "I have been perfecting",
            "this site and the overall structure for the course for",
            "a few years now and I think it's finally coming together.")
        )
      )
    },
    "2" = {
      list(
        code = "multiply_times_two <- function(x) x * 2\nmultiply_times_two(2)",
        lesson_html = div(
          h5(class='display-5 text-center',
             "... but things are under construction"
          ),
          p(
            class = "p-2",
            "Please note that as the site currently stands, there is no guarantee that your current",
            "progress or even login credentials will remain.", "This site is heavily under construction and what follows is a course under development."
          )
        )
      )
    },
    "3" = {
      list(
        code = "multiply_times_two <- function(x) x * 2\nmultiply_times_two(4)",
        lesson_html = withTags(
          div(class='p-2',
            h4('Getting Familiar with VIM movement.'),
            p(
              "Take note of what the", code("h"), ",", code("j"), ",", code("k"), ",", "and", code("l"), "keys do.",
              "If you are unfamiliar with", a(href = "https://www.vim.org/about.php", 'Vim', target='_blank'), ", I hope you will allow me to help you get acquainted.",
              "However if this feels 'too weird' and you want to slap me for breaking your text editor, you can",
              "go into the settings panel ", icon("user"), " and uncheck ", mark("Use Vim"), "."
            ),
            p("Once you feel familiar with", code("h"), ",", code("j"), ",", code("k"), ",", "and", code("l"),
              "use them to navigate to the", code('4'), "in the function", code('multiply_times_two'), ".",
              "Once you are hovered over it, push the letter", code("r"), "and then the number", code("5"), ".",
              "Note how you can now navigate and replace text and the output will update automatically.")
          )
        )
      )
    },
    list(
      code="",
      lesson_html=div("Under Construction")
    )
  )
}
