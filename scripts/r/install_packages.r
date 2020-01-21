################################################################################
##
## [ PROJ ] Unrollment project
## [ FILE ] install_packages.r
## [ AUTH ] Benjamin Skinner (@btskinner)
## [ INIT ] 21 January 2020
##
################################################################################

## -----------------
## CRAN
## -----------------

## required packages
recpkgs <- c("tidyverse",
             "tidymodels",
             "testthat")

## compare against already installed
misspkgs <- recpkgs[!(recpkgs %in% installed.packages()[,"Package"])]

## install those that are missing
if (length(misspkgs)) {
    install.packages(misspkgs)
} else {
    message("- All required CRAN packages already installed!")
}

## -----------------------------------------------------------------------------
## END SCRIPT
################################################################################
