% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ace-annotate.R
\name{aceAnnotate}
\alias{aceAnnotate}
\title{Enable Error Annotations for an Ace Code Input}
\usage{
aceAnnotate(inputId, session = shiny::getDefaultReactiveDomain())
}
\arguments{
\item{inputId}{The id of the input object}

\item{session}{The \code{session} object passed to function given to
shinyServer}
}
\value{
An observer reference class object that is responsible for offering
code annotations. See \code{\link[shiny]{observeEvent}} for more details.
You can use \code{suspend} or \code{destroy} to pause to stop dynamic code
completion.

The observer reference object will send a custom shiny message using
\code{session$sendCustomMessage} to the annotations endpoint containing
a json list of annotation metadata objects. The json list should have
a structure akin to:

\preformatted{
  [
    {
       row:  <int: row of annotation reference>,
       col:  <int: column of annotation reference>,
       type: <str: "error", "alert" or "flash">,
       html: <str: html of annotation hover div, used by default over text>,
       text: <num: text of annotation hover div>,
    }
  ]
  }
}
\description{
This function dynamically evaluate R for syntax errors using the
\code{\link{parse}} function.
}
\details{
You can implement your own code completer by observing modification events to
\code{input$<editorId>_shinyAce_annotationTrigger} where <editorId> is the
\code{aceEditor} id. This input is only used for triggering completion and
will contain a random number. However, you can access
\code{session$input[[inputId]]} to get the input text for parsing.
}
