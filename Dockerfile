FROM rocker/tidyverse



#RUN apt install -y software-properties-common dirmngr libcurl4-openssl-dev \
#    libssl-dev libssh2-1-dev libxml2-dev zlib1g-dev make git-core \
#    libcurl4-openssl-dev libxml2-dev libpq-dev cmake \
#    r-base r-base-dev libsodium-dev libsasl2-dev librabbitmq-dev


WORKDIR /app/
COPY DESCRIPTION .
COPY NAMESPACE .
COPY R R
COPY node_modules node_modules

#RUN R -e "install.packages(c('ggpubr', 'DT'))"
RUN R -e "devtools::install_deps('.')"
RUN R -e "devtools::document('.')"
RUN R -e "devtools::install('.')"
