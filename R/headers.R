#' headers
#' @export
headers <- function() {
  tags$head(
    includeCSS(
      "www/styles.css"
    ),
    tags$script(
      src = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js", integrity = "sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM", crossorigin = "anonymous"
    ),
    HTML('<meta name="viewport" content="width=device-width, initial-scale=1">')
  )
}
