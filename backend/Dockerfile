FROM rstudio/plumber
MAINTAINER Freddy Drennan <fdrennan@ndexr.com>

WORKDIR /app
COPY plumber.R plumber.R
COPY R R
COPY DESCRIPTION
RUN R -e "devtools::install_deps()"
RUN R -e "devtools::document()"
RUN R -e "devtools::install()"
