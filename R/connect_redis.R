#' connect_redis
#' @export
connect_redis <- function(host = Sys.getenv("REDIS_HOST"), port = Sys.getenv("REDIS_PORT")) {
  r <- hiredis(host = host, port = port)
  r
}
