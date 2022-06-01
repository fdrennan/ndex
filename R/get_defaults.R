#' get_defaults
#' @example
get_defaults <- function(id=NULL) {
  r <- connect_redis()
  defaults <- r$GET(id)
  if (is.null(defaults)) {
    defaults <- list()
  } else {
    defaults <- fromJSON(defaults)
  }
  defaults
}



