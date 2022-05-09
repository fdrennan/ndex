#' #' ace_editor
#' #' @export
#' ace_editor <- function(outputId, value, mode, theme, vimKeyBinding = FALSE,
#'          readOnly = FALSE, height = "400px", fontSize = 12, debounce = 1000,
#'          wordWrap = FALSE, showLineNumbers = TRUE, highlightActiveLine = TRUE,
#'          selectionId = NULL, cursorId = NULL, hotkeys = NULL, code_hotkeys = NULL,
#'          autoComplete = c("disabled", "enabled", "live"), autoCompleters = c(
#'            "snippet",
#'            "text", "keyword"
#'          ), autoCompleteList = NULL, tabSize = 4,
#'          useSoftTabs = TRUE, showInvisibles = FALSE, setBehavioursEnabled = TRUE,
#'          showPrintMargin = TRUE, autoScrollEditorIntoView = FALSE,
#'          maxLines = NULL, minLines = NULL, placeholder = NULL) {
#'   browser()
#'   escapedId <- gsub("\\.", "\\\\\\\\.", outputId)
#'   escapedId <- gsub("\\:", "\\\\\\\\:", escapedId)
#'   payloadLst <- list(
#'     id = escapedId, vimKeyBinding = vimKeyBinding,
#'     readOnly = readOnly, wordWrap = wordWrap, showLineNumbers = showLineNumbers,
#'     highlightActiveLine = highlightActiveLine, selectionId = selectionId,
#'     cursorId = cursorId, hotkeys = hotkeys, code_hotkeys = code_hotkeys,
#'     autoComplete = match.arg(autoComplete), autoCompleteList = autoCompleteList,
#'     tabSize = tabSize, useSoftTabs = useSoftTabs, showInvisibles = showInvisibles,
#'     showPrintMargin = showPrintMargin, setBehavioursEnabled = setBehavioursEnabled,
#'     autoScrollEditorIntoView = autoScrollEditorIntoView,
#'     maxLines = maxLines, minLines = minLines, placeholder = placeholder
#'   )
#'   if (is.empty(autoCompleters)) {
#'     payloadLst$autoComplete <- "disabled"
#'   } else if (any(autoCompleters %in% c(
#'     "snippet", "text", "static",
#'     "keyword", "rlang"
#'   ))) {
#'     payloadLst$autoCompleters <- I(autoCompleters)
#'   } else {
#'     payloadLst$autoComplete <- "disabled"
#'   }
#'   if (!missing(value)) {
#'     payloadLst$value <- paste0(unlist(value), collapse = "\n")
#'   }
#'   if (!missing(mode)) {
#'     payloadLst$mode <- mode
#'   }
#'   if (!missing(theme)) {
#'     payloadLst$theme <- theme
#'   }
#'   if (!is.empty(as.numeric(fontSize))) {
#'     payloadLst$fontSize <- as.numeric(fontSize)
#'   }
#'   if (!is.empty(as.numeric(debounce))) {
#'     payloadLst$debounce <- as.numeric(debounce)
#'   }
#'   payloadLst <- Filter(f = function(y) !is.empty(y), x = payloadLst)
#'   payload <- jsonlite::toJSON(payloadLst, null = "null", auto_unbox = TRUE)
#'   if (is.empty(code_hotkeys)) {
#'     cfile <- NULL
#'   } else {
#'     cfile <- paste0(
#'       "shinyAce/code/code-jump-", code_hotkeys[[1]],
#'       ".js"
#'     )
#'   }
#'   tagList(
#'     singleton(tags$head(
#'       initResourcePaths(), tags$script(src = "shinyAce/ace/ace.js"),
#'       tags$script(src = "shinyAce/ace/ext-language_tools.js"),
#'       tags$script(src = "shinyAce/ace/ext-searchbox.js"), tags$script(src = "shinyAce/shinyAce.js"),
#'       tags$script(src = cfile), tags$link(
#'         rel = "stylesheet",
#'         type = "text/css", href = "shinyAce/shinyAce.css"
#'       )
#'     )),
#'     pre(id = outputId, class = "shiny-ace", style = paste(
#'       "height:",
#'       validateCssUnit(height)
#'     ), `data-auto-complete-list` = jsonlite::toJSON(autoCompleteList)),
#'     tags$script(
#'       type = "application/json", `data-for` = escapedId,
#'       HTML(payload)
#'     )
#'   )
#' }
