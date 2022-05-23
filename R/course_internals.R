

#' course_internals
#' We use page as an argument to lesson_intro because we can
#' have a second argument that defines a course
#' @export
course_internals <- function(page) {
  switch(as.character(page),
    "1" = list(
      lesson_html = div(
        class = "row",
        div(
          class = "p-1",
          h5(
            class = "display-5 text-center",
            "Build or Buy"
          ),
          p(
            class = "lead fade-in-text",
            div(
              class = "text-center",
              "Thanks for visiting - this site is under development.",
              "Please step through the next few slides to get oriented."
            )
          )
        )
      ),
      code = "",
      display_editor = FALSE
    ),
    "2" = list(
      header = h5("Orientation", class = "display-5 text-center p-2"),
      lesson_html = div(
        class = "row",
        div(
          class = "p-1",
          h5("Building R Applications", class = "text-center"),
          p(
            class = "lead", "Building software is hard. Writing sentences is harder.",
            "But here I am, figuring it out.", "When writing software, figuring it out is the goal.",
            "Many think that software development is leetcode and algorithms, but I'd argue that it's much more intuitive.",
            "Applications are mysteries to be unraveled and explored and tested.",
            "You build applications iteratively, while constantly abstracting.",
            "The more talented you are, the more abstractly you start your project.",
            "For example, do you use a file watcher or aliases?",
            "Does your project have a Makefile, Dockerfile, .gitignore?",
            "What does the .Rprofile or .Renviron file do? Should I use them?"
          ),
          p(
            "So on the topic of abstraction, this application was built entirely by the author.",
            "For those who aren't newcomers to the software development scene, you would not",
            "be surprised to learn that this is a Shiny application built with a Plumber API",
            "backend. Everything is spun up and down using Docker Compose, and I serve this application",
            "to the world on my home computer in Colorado - using autossh to connect to the web through an EC2 server."
          ),
          p("If all of this seems complicated to you, don't worry - it is. But, one goal of mine is to teach",
            "how to replicate what I am doing here. I am a developer that loves to teach and tinker. I love learning about",
            "new things but I also like to be a master at something.", "I get bored easily so I can be engineer one day when I feel like improving the site",
            "or teacher another day when I feel like sharing how to build some component of it."),
          p("I hope you learn something while you're here!")
        )
      ),
      code = "",
      display_editor = FALSE
    ),
    "3" = list(
      lesson_html = div(
        class = "row",
        div(
          class = "p-1",
          h5(
            class = "display-5 text-center",
            icon("user"), "Settings"
          ),
          p(
            class = "lead",
            div(
              class = "text-justify",
              "In the nav bar above, you can click on this icon to go to your settings pane.",
              "This site is built with modules that communicate and store state.",
              "The settings panel contains inputs that change the state of the application - in this case,",
              "it is a shiny module that produces an output and feeds that reactive output into other shiny modules."
            )
          )
        )
      ),
      code = "",
      display_editor = FALSE
    ),
    "music" = list(
      header = HTML('<iframe width="560" height="315"
                    src="https://www.youtube-nocookie.com/embed/5qap5aO4i9A"
                    title="YouTube video player" frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write;
                    encrypted-media; gyroscope;
                    picture-in-picture" allowfullscreen></iframe>'),
      lesson_html = div(class = "row"),
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
