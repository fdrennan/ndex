#' ui_course
#' @export
ui_course <- function(id = "course") {
  ns <- NS(id)
  div(
    class = "row",
    uiOutput(ns('courseInputs')),
    uiOutput(ns("coursePanel"))
  )
}

#' server_course
#' @export
server_course <- function(id = "course", settings, credentials) {
  ace_envir <- environment()
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      authorized <- reactive({
        req(credentials()()$authorized)
      })
      email <- reactive({
        req(credentials()()$email)
        email <- credentials()()$email
      })

      init_value <- reactive({
        req(authorized())
        req(input$course)
        current_page <- input$nextbutton - input$prevbutton + 1
        if (input$course == "under construction") {
          out <- course_internals(current_page)
        } else if (input$course == "music") {
          out <- course_internals("music")
        }
        out
      })

      output$courseInputs <- renderUI({
        defaults <- get_defaults(ns(email()))
        course <- setDefault(defaults$course, "under construction")

        div(
          class = "p-4 d-flex justify-content-center",
          selectizeInput(ns("course"), h3("Select Course"), c("under construction", "music"), course)
        )
      })

      output$courseMainPanel <- renderUI({
        req(authorized())
        course_internals <- init_value()

        if (course_internals$display_editor) {

          out <- withClass("row",
            withClass('col-lg-3 col-xl-3'),
            withClass('col-lg-6 col-xl-6', course_internals$header),
            withClass('col-lg-3 col-xl-3'),
            withClass('col-lg-1 col-xl-1'),
            withClass('col-lg-4 col-xl-4 p-3', uiOutput(ns("classHtml"))),
            withClass('col-lg-3 col-xl-3 p-3', uiOutput(ns("aceEditor"))),
            withClass('col-lg-3 col-xl-3 p-3', uiOutput(ns("output"))),
            withClass('col-lg-1 col-xl-1')
          )
        } else {
          out <- withClass(
            "row p-2 h-100",
            withClass("col-lg-3 col-xl-3 col-md-2 col-sm-2 col-xs-2"),
            withClass("col-lg-6 col-xl-6 col-md-8 col-sm-8 col-xs-8",
              course_internals$header,
              course_internals$lesson_html
            )
          )
        }
        out
      })

      output$coursePanel <- renderUI({
        req(authorized())
        withTags(
          div(
            id = "carouselExampleIndicators",
            class = "carousel slide", `data-ride` = "carousel",
            div(
              class = "carousel-inner",
              uiOutput(ns("courseMainPanel"))
            ),
            button(
              id = ns("prevbutton"),
              class = "carousel-control-prev action-button",
              role = "button",
              span(class = "carousel-control-prev-icon", `aria-hidden` = "true"),
              span(class = "sr-only", "Previous")
            ),
            button(
              id = ns("nextbutton"),
              class = "carousel-control-next action-button", role = "button",
              span(class = "carousel-control-next-icon", `aria-hidden` = "true"),
              span(class = "sr-only", "Next")
            )
          )
        )
      })

      output$aceEditor <- renderUI({
        req(authorized())
        req(settings$fontSize)
        req(settings$useVim)
        course_internals <- init_value()
        init_value <- course_internals$code
        if (course_internals$display_editor) {
          aceEditor(
            ns("code"),
            mode = "r",
            selectionId = ns("selection"),
            code_hotkeys = list(
              "r",
              list(
                run_key = list(
                  win = "CTRL-ENTER|SHIFT-ENTER",
                  mac = "CMD-ENTER|SHIFT-ENTER"
                )
              )
            ),
            value = init_value,
            autoComplete = "enabled",
            fontSize = settings$fontSize,
            vimKeyBinding = settings$useVim,
            showLineNumbers = TRUE,
            height = "200px"
          )
        } else {
          div()
        }
      })

      code <- reactiveVal("")

      crc <- reactive({
        input$code_run_key
      })
      observeEvent(crc, {
        if (!is.empty(crc()$selection)) {
          code(crc()$selection)
        } else {
          code(crc()$line)
        }
      })

      observeEvent(input$eval, {
        if (!is.empty(input$code_selection)) {
          code(input$code_selection)
        } else {
          code(input$code)
        }
      })

      output$classHtml <- renderUI({
        req(authorized())
        course_internals <- init_value()
        course_internals$lesson_html
      })

      output$output <- renderUI({
        req(authorized())
        req(input$code)
        course_internals <- init_value()
        if (course_internals$display_editor) {
          HTML(markdown::markdownToHTML(file=NULL,text=input$code, fragment.only = T))
        } else {
          div()
        }
      })
    }
  )
}
