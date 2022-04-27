guts <- function() {
  fluidRow(
    tabsetPanel(
      type = "hidden", selected = "Dev Stuff",
      tabPanel(
        "Home",
        "Home"
      ),
      tabPanel(
        "User Settings",
        "Cool"
      ),
      tabPanel(
        "Dev Stuff",
        fluidRow(
          inputPanel(
            selectizeInput("panel", "Panel", choices = c("html", "code"), "html")
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
  )
}
