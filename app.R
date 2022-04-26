library(ndex)
dotenv::load_dot_env()
# system('/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css')

#' ui
#' @export
ui <- function(incoming) {
  fluidPage(
    headers(),
    navbarPage(position = 'fixed-bottom',
      title = h6("shinytemp"),
      tabPanel(
        h6("Main"),
        "Home"
      ),
      tabPanel(
        h6("User Settings", class='text-right'),
        "Cool"
      ),
      tabPanel(
        h6("Dev Stuff"),
        inputPanel(
          selectizeInput('panel', 'Panel', choices=c('html', 'code'), 'html')
        ),
        tabsetPanel(
          id = "hidden_tabs",
          # Hide the tab values.
          # Can only switch tabs by using `updateTabsetPanel()`
          type = "hidden",
          tabPanelBody("html", ui_template()),
          tabPanelBody("code", "Panel 2 content")
        )
      )
    )
  )
}

#' server
#' @export
server <- function(input, output, session) {
  observe({
    updateTabsetPanel(session, "hidden_tabs", selected = input$panel)
  })
  server_template()
}

shinyApp(
  ui = ui,
  server = server
)
