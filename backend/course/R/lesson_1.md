# Install the following

[Install R](https://cran.r-project.org/) [Install
RStudio](https://www.rstudio.com/products/rstudio/download/)

## Windows Specific Instructions

[Install RTools](https://cran.r-project.org/bin/windows/Rtools/)

After installing RTools, run the following in the RStudio Console

    write('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', file = "~/.Renviron", append = TRUE)

# Documentation

Copy the output of the following code in the RStudio Console, and
document the results in a comment below.

    install.packages("jsonlite", type = "source")
