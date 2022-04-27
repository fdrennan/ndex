library(ndex)
library(shiny.router)
library(shinyjs)
dotenv::load_dot_env()
# system('/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css')

router <- make_router(
  route("/", bs_text_ui()),
  route("other", 'asdf')
)

# ui <- fluidPage(
#   title = "Router demo",
#
# )

# server <- function(input, output, session) {
#
# }

#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    router$ui
  )
}



#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  server_navbar()
}

shinyApp(
  ui = ui,
  server = server
)
