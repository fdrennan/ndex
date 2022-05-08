FROM rstudio/plumber
MAINTAINER Freddy Drennan <fdrennan@ndexr.com>

RUN R -e "install.packages('renv')"

WORKDIR /app
COPY plumber.R .

