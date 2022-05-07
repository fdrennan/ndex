#' ui_contact_us
#' @export
ui_contact_us <- function(id = "contact_us") {
  ns <- NS(id)
  withTags(
    section(
      withTags(
        div(
          class = "row",
          div(class = "col", div(
            class = "card-border-0",
            div(
              class = "card-body text-center",
              h2(b("Full Stack R Contracting")),
              div(
                class = "row text-center justify-content-center",
                div(
                  class = "col-auto",
                  div(
                    class = "input-group-lg input-group m-3",
                    div(
                      class = "m-1 my-auto",
                      textInput(
                        ns("email"), NULL, "", width = '90%'
                      )
                    ),
                    div(
                      class = "input-group-append my-auto",
                      actionButton(ns("submit"), class = "btn btn-success", b("Submit"))
                    )
                  )
                )
              )
            )
          ))
        )
      )
    )
  )
}

#' server_contact_us
#' @export
server_contact_us <- function(id = "contact_us") {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      observe({
        print(reactiveValuesToList(input))
      })
    }
  )
}
