#' other_links
#' @export
other_links <- function() {
  withTags(
    section(
      fluidRow(
        div(
          class = (div_css <- "col-lg-6 col-md-6 my-1 mb-md-0"),
          ul(
            class = (ul_css <- "list-unstyled mb-0"),
            h5(class = (h5_css <- "text-uppercase"), "Useful Resources"),
            li(a(
              href = "https://hackerthemes.com/bootstrap-cheatsheet/", class = (a_css <- "text-white"), "Bootstrap Cheatsheet"
            )),
            li(a(
              href = "https://github.com/fdrennan/ndex", class = a_css, "Get the Repo"
            ))
          )
        ),
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = h5_css, "Development"),
            li(a(
              href = "https://ndexr.com/youtrack", class = a_css, "YouTrack"
            )),
            li(
              a(class = a_css, href = "/#!/theme", "Theme")
            )
          )
        )
      )
    )
  )
}
