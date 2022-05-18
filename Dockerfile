FROM rust:1.58-buster
RUN echo "deb https://cloud.r-project.org/bin/linux/debian buster-cran40/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'

RUN apt update -qq -y

RUN apt install -y software-properties-common dirmngr libcurl4-openssl-dev \
    libssl-dev libssh2-1-dev libxml2-dev zlib1g-dev make git-core \
    libcurl4-openssl-dev libxml2-dev libpq-dev cmake \
    r-base r-base-dev libsodium-dev libsasl2-dev librabbitmq-dev libhiredis-dev

RUN R -e "install.packages(c('tidyverse', 'devtools'))"


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
