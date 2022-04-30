#'
#' #' ui_contact
#' #' @export
#' ui_contact <- function(id='contact') {
#'   ns <- NS(id)
#'   actionButton(ns("contact_us"), "Contact Us", class = "btn-sm")
#' }
#'
#' #' server_contact
#' #' @export
#' server_contact <- function(id='contact') {
#'   moduleServer(id, function(input, output, session) {
#'     ns <- session$ns
#'
#'     iv <- InputValidator$new()
#'
#'     iv$add_rule("email", sv_required())
#'     iv$add_rule("email", sv_email())
#'
#'     iv$add_rule("message", sv_required())
#'     iv$add_rule("message",
#'                 ~ if (nchar(.) > 140) paste("Maximum length exceeded by", nchar(.) - 140))
#'
#'     observeEvent(input$contact_us, {
#'       showModal(
#'         modalDialog(size = "s", easyClose = FALSE, title = "Contact Us",
#'                     footer = NULL,
#'                     tagList(
#'                       textInput(ns("email"), "Your email"),
#'                       textAreaInput(ns("message"), "Message", rows = 4),
#'                       helpText("Maximum 140 characters"),
#'                       div(class = "text-right",
#'                           actionButton(ns("cancel"), "Cancel"),
#'                           actionButton(ns("send"), "Send email", class = "btn-primary")
#'                       )
#'                     )
#'         )
#'       )
#'     })
#'
#'     close <- function() {
#'       removeModal()
#'       iv$disable()
#'     }
#'
#'     observeEvent(input$send, {
#'       iv$enable()
#'       if (iv$is_valid()) {
#'         close()
#'         showNotification("Message sent (not really)", type = "message")
#'       }
#'     }, ignoreInit = TRUE)
#'
#'     observeEvent(input$cancel, {
#'       close()
#'     }, ignoreInit = TRUE)
#'   })
#' }
