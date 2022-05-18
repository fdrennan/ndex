FROM rocker/tidyverse



RUN apt install -y software-properties-common libhiredis-dev


WORKDIR /app/
COPY DESCRIPTION .
COPY NAMESPACE .
COPY R R
COPY node_modules node_modules
COPY inst inst

#RUN R -e "install.packages(c('ggpubr', 'DT'))"
RUN R -e "devtools::install_deps('.')"
RUN R -e "devtools::document('.')"
RUN R -e "devtools::install('.')"
