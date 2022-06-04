#' import_course
#' @export
import_course <- function() {
  courses <- fs::dir_ls("courses", recurse = TRUE, regexp = "yaml")

  courses <- map(
    courses, function(x) {
      conf <- read.config(x)
      conf$directory <- path_dir(x)
      conf
    }
  )

  courses
}

if (FALSE) {
  library(ndex)
  import_course()
}
