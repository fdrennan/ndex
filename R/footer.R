#' ui_footer
#' @export
ui_footer <- function(id = "footer") {
  ns <- NS(id)
  uiOutput(ns("footer"))
}

#' server_footer
#' @export
server_footer <- function(id = "footer", settings, credentials) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      output$footer <- renderUI({
        hide_footer <- isTRUE(settings$minimal)
        if (hide_footer) {
          return(div())
        }
        tags$footer(
          class = "bg-dark text-white p-2 m-0",
          div(
            class = "container",
            div(class = "text-center", ui_social_links()),
            div(class = "text-center", other_links()),
            # div(class = "p-2", div(
            #   p(class = "text-justify font-weight-light", tags$small(
            #     "I have primarily used R during my engineering career.",
            #     "This site is a passion project of mine. Since I love to build really great software for startups,",
            #     "I want to market my skills by creating a startup with software I have built.",
            #     "ndexr is a system built almost entirely in R, and is a framework that can be redesigned",
            #     "for other use cases.", "It aspires to be a go-to template for building a highly extensible POC for a software company",
            #     "designed with R leading the way."
            #   ))
            # )),
            div(
              class = "text-center",
              "© 2022 Copyright:",
              tags$a(class = "text-white", href = "https://ndexr.com", "ndexr")
            )
          )
        )
      })
    }
  )
}
