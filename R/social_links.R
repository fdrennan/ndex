#' ui_social_links
#' @export
ui_social_links <- function() {
  withTags(
    section(
      class = "mb-1",
      map2(
        c("https://www.linkedin.com/in/freddydrennan/", "https://www.github.com/fdrennan/", "https://discord.gg/8cJ4NAjV39"),
        c("bi bi-linkedin", "bi bi-github", "bi bi-discord"),
        function(url, icon) {
          a(
            class = "btn btn-outline-light btn-floating m-1",
            href = url,
            role = "button",
            i(class = icon),
            target = "_blank"
          )
        }
      )
    )
  )
}
