#' other_links
#' @export
other_links <- function() {
  div_css <- "col-lg-4 col-md-4 my-1 mb-md-0"
  a_css <- "text-white"
  ul_css <- "list-unstyled mb-0"
  withTags(
    section(
      fluidRow(
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = (h5_css <- "text-uppercase"), "Useful Resources"),
            li(a(
              href = "https://hackerthemes.com/bootstrap-cheatsheet/", class = a_css, "Bootstrap Cheatsheet", target = "_blank"
            )),
            li(a(
              href = "https://www.rstudio.com/resources/cheatsheets/", class = a_css, "RStudio Cheatsheets", target = "_blank"
            ))
          )
        ),
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = h5_css, "ndexr versions"),
            li(a(
              href = "https://github.com/fdrennan/ndex", class = a_css, "literally this", target = "_blank"
            )),
            li(a(
              href = "https://github.com/fdrennan/ndexr-v2.0", class = a_css, "ndexr v2.0", target = "_blank"
            )),
            li(a(
              href = "https://github.com/fdrennan/ndexr-platform", class = a_css, "ndexr v1.0", target = "_blank"
            )),
          )
        ),
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = h5_css, "Development"),
            li(a(
              href = "http://ndexr.com:8385", class = a_css, "YouTrack"
            )),
            li(a(
              href = "http://ndexr.com:8080", class = a_css, "Draw"
            )),
            li(a(
              href = "http://ndexr.com:8787", class = a_css, "RStudio Server"
            )),
            li(
              a(class = a_css, href = "/#!/theme", "Theme")
            )
          )
        )
        # div(class='col-lg-4')
      )
    )
  )
}
