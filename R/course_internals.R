

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
            class = "lead", "Building software is hard.",
            "When writing software, we are constantly figuring things out while repeating.",
            "Applications are mysteries to be unraveled and explored and tested.",
            "You build applications iteratively, while constantly abstracting.",
            "The more talented you are, the more abstractly you start your project.",
            "For example, do you use a file watcher or aliases?",
            "Does your project have a Makefile, Dockerfile, .gitignore?",
            "What does the .Rprofile or .Renviron file do? Should I use them?"
          ),
          p("Another aspect of application building in industry is that you need services to talk to each other.",
            "This can be difficult to learn without a solid push in the right direction.",
            "In this course we will talk a lot about networking - which is the pathway to getting access to a ton of awesome services.",
            "I think with this skill you'll be able to more easily create complex applications that have interesting behaviors and unique purposes.")

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
          div(
            class = "p-3",
            p(
              class = "lead text-justify",
              "In the nav bar above, you can click on the user icon to go to your settings pane."
            )
          )
        )
      ),
      code = "",
      display_editor = FALSE
    ),
    "4" = list(
      lesson_html = withTags(
        div(
          class = "row",
          div(
            class = "p-1",
            h5(
              class = "display-5 text-center",
              "Dump of Topics"
            ),
            dl(
              class = "row",
              dt(
                class = "col-sm-4", "Communication Between Services"
              ),
              dd(
                class = "col-sm-8",
                p(
                  a(href='https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/', 'HTTP Load Balancing')
                ),
                p(
                  a(href='https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/', 'Reverse Proxy')
                ),
                p(a(href='https://devhints.io/docker-compose', 'Cheatsheet')),
                p(a(href='https://docs.docker.com/compose/networking/', "Docker Compose Networking")),
                a(href='https://www.gnu.org/software/make/manual/make.html', 'GNU Make'),
                a(href='https://jetbrains.com', 'JetBrains'),
                a(href='https://www.rstudio.com/products/rstudio/download/', 'RStudio')
              )
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
