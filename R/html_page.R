#' html_page
#' @export
html_page <- function(title = "Template", ...) {

  # message('Adding resources from ndex')
  # dir_loc <- system.file('www', package = 'ndex')
  # shiny::addResourcePath(
  #   prefix = "www",
  #   directoryPath = dir_loc
  # )

  initResourcePaths()
  tags$html(
    tags$head(
      lang = "en",
      includeCSS(
        "www/styles.css"
      ),
      tags$meta(charset = "utf-8"),
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
      tags$script(
        src = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js", integrity = "sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM", crossorigin = "anonymous"
      ),
      useShinyjs(),
      tags$title(title),
      tags$script(
        src = paste0(
          "https://cdn.jsdelivr.net/npm/js-cookie@rc/",
          "dist/js.cookie.min.js"
        )
      ),
      tags$script(src = "www/cookies.js")
    ),
    tags$body(
      ...
    )
  )
}
