#' connect_table
#' @export
connect_table <- function(service, ...) {
  stopifnot(service %in% c("lite"))
  if (service == "lite") {
    con <- dbConnect(RSQLite::SQLite(), ...)
    return(con)
  }
}
