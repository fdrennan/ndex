#' ui_social_links
#' @export
ui_social_links <- function() {
  withTags(
    section(
      class = "mb-4",
      map2(
        c("#!", "#!", "#!"),
        c("bi bi-linkedin", "bi bi-twitter", "bi bi-github"),
        function(url, icon) {
          a(
            class = "btn btn-outline-light btn-floating m-1",
            href = url,
            role = "button",
            i(class = icon)
          )
        }
      )
    )
  )
}
