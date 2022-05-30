#' withClass
#' @export
withClass <- function(class='', ...) {
  class <- paste(class, collapse = ' ')
  div(..., class=class)
}
