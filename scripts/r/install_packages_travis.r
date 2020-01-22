################################################################################
##
## [ PROJ ] Unrollment project
## [ FILE ] install_packages_travis.r
## [ AUTH ] Benjamin Skinner (@btskinner)
## [ INIT ] 21 January 2020
##
################################################################################

## --- PURPOSE -----------------------------------------------------------------
##
## Some packages have dependencies that won't install on Travis
## (rstanarm). This script is more specific about the packages that
## install so that we can check functions on Travis CI.
##
## -----------------------------------------------------------------------------

## -----------------
## CRAN
## -----------------

## required packages
recpkgs <- c("rsample",
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
