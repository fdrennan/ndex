#' filler_text
#' @param n_sentences The number of sentences to return.
#' @import httr jsonlite
#' @export
filler_text <-
  function(n_sentences = 10) {
    out <-
      fromJSON(
        content(
          GET(url = "https://baconipsum.com/api/", query = list(
            type = "meat-and-filler",
            sentences = n_sentences
          )), "text"
        )
      )

    paste0(strsplit(out, "\\. ")[[1]], ".")
  }
