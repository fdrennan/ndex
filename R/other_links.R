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
              href = "https://hackerthemes.com/bootstrap-cheatsheet/", class = a_css, "Bootstrap Cheatsheet"
            ))
          )
        ),
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = h5_css, "ndexr versions"),
            li(a(
              href = "https://github.com/fdrennan/ndex", class = a_css, "literally this"
            )),
            li(a(
              href = "https://github.com/fdrennan/ndexr-v2.0", class = a_css, "ndexr v2.0"
            )),
            li(a(
              href = "https://github.com/fdrennan/ndexr-platform", class = a_css, "ndexr v1.0"
            )),
          )
        ),
        div(
          class = div_css,
          ul(
            class = ul_css,
            h5(class = h5_css, "Development"),
            # li(a(
            #   href = "https://ndexr.com/youtrack", class = a_css, "YouTrack"
            # )),
            li(
              a(class = a_css, href = "/#!/theme", "Theme")
            )
            # li(
            #   a(class = a_css, href = "/#!/terminal", "Terminal")
            # )
            # li(
            #   a(class = a_css, href = "/#!/cookie", "Cookie")
            # )
          )
        )
        # div(class='col-lg-4')
      )
    )
  )
}
