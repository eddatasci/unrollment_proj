################################################################################
##
## [ PROJ ] Unrollment project
## [ FILE ] func_utils.r
## [ AUTH ] Benjamin Skinner (@btskinner)
## [ INIT ] 21 January 2020
##
################################################################################

## quick paste functions
`%+%` <- function(a, b) paste(a, b, sep = "")   # a %+% b --> ab
`%_%` <- function(a, b) paste(a, b, sep = "_")  # a %_% b --> a_b
`%.%` <- function(a, b) paste(a, b, sep = ".")  # a %.% b --> a.b

## are unique values of x < n (default = 20) ? TRUE : FALSE
few_unique <- function(x, n = 20) { ifelse(length(unique(x)) < n, TRUE, FALSE) }
