################################################################################
##
## [ PROJ ] Unrollment project
## [ FILE ] testthat.r
## [ AUTH ] Benjamin Skinner (@btskinner)
## [ INIT ] 21 January 2020
##
################################################################################

## if no external argument setting root, then assume in ./tests/
args <- commandArgs(trailingOnly = TRUE)
root <- ifelse(length(args) == 0, file.path(".."), args)

## run all tests in directory
testthat::test_dir(file.path(root, "tests", "testthat"))
