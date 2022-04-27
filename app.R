library(ndex)
library(shinyjs)
dotenv::load_dot_env()
# system('/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css')


#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    bs_text_ui()
  )
}



#' server
#' @export
server <- function(input, output, session) {
  server_navbar()
}

shinyApp(
  ui = ui,
  server = server
)
