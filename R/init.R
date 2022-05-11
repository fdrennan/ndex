.global <- new.env()

initResourcePaths <- function() {
  if (is.null(.global$loaded)) {
    shiny::addResourcePath(
      prefix = "www",
      directoryPath = system.file('www', package = 'ndex')
    )
    .global$loaded <- TRUE
  }
  HTML("")
}
