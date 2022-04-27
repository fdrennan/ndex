#' bs_text_ui
#' @export
bs_text_ui <- function() {
  fluidRow(
    column(
      12,
      withTags(
        div(
          h1("h1 Heading"),
          h2("h2 Heading"),
          h3("h3 Heading"),
          h4("h4 Heading"),
          h5("h5 Heading"),
          h3(
            "Fancy display heading",
            small(
              class = "text-muted",
              "With faded secondary text"
            )
          ),
          h1("Display 1", class = "display-1"),
          h2("Display 2", class = "display-2"),
          h3("Display 3", class = "display-3"),
          h4("Display 4", class = "display-4"),
          h5("Display 5", class = "display-5"),
          h5("Display 6", class = "display-6"),
          p(class = "lead", "This is a lead paragraph. It stands out from regular paragraphs."),
          p("You can use the mark tag to", mark("highlight"), "text"),
          p(del("This line of text is meant to be treated as deleted")),
          p(s("This line of text is meant to be treated as no longer accurate")),
          p(ins("This line of text is meant to be treated as an addition to the document.")),
          p(u("This line of text will render as underlined")),
          p(small("This line of text is meant to be treated as fine print.")),
          p(strong("This line rendered as bold text.")),
          p(em("This line rendered as italicized text.")),
          p(abbr(title = "attribute"), "attr"),
          p(abbr(title = "HyperText Markup Language", class = "initialism", "HTML")),
          blockquote(
            class = "blockquote",
            p("A well-known quote, contained in a blockquote element")
          ),
          figure(
            blockquote(class = "blockquote", p(
              "A well-known quote, contained in a blockquote element"
            )),
            figcaption(
              class = "blockquote-footer",
              "Someone famous in ", cite(title = "Source Title", "Source Title")
            )
          ),
          figure(
            class = "text-center",
            blockquote(class = "blockquote", p(
              "A well-known quote, contained in a blockquote element"
            )),
            figcaption(
              class = "blockquote-footer",
              "Someone famous in ", cite(title = "Source Title", "Source Title")
            )
          ),
          figure(
            class = "text-end",
            blockquote(class = "blockquote", p(
              "A well-known quote, contained in a blockquote element"
            )),
            figcaption(
              class = "blockquote-footer",
              "Someone famous in ", cite(title = "Source Title", "Source Title")
            )
          ),
          ul(
            class = "list-unstyled",
            li("This is a list"),
            li("It appears completely unstyled"),
            li(
              "Nested lists",
              ul("are unaffected")
            )
          ),
          ul(
            class = "list-inline",
            li(class = "list-inline-item", "This is a list item"),
            li(class = "list-inline-item", "This is another"),
            li(class = "list-inline-item", "Displayed inline")
          ),
          dl(
            class = "row",
            dt(
              class = "col-sm-3", "Description lists"
            ),
            dd(class = "col-sm-9", "A description list is perfect for defining terms"),
            dt(
              class = "col-sm-3", "Term"
            ),
            dd(
              class = "col-sm-9",
              p("Definition for the term"),
              p("And some more placeholder term.")
            )
          )
        )
      )
    )
  )
}
