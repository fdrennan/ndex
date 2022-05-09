FROM rocker/verse
MAINTAINER Freddy Drennan <fdrennan@ndexr.com>

WORKDIR /app
COPY R R
COPY DESCRIPTION .
RUN R -e "devtools::install_deps()"
RUN R -e "devtools::document()"
RUN R -e "devtools::install()"
COPY plumber.R .
