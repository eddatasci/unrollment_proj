################################################################################
##
## [ PROJ ] Unrollment project
## [ FILE ] func_cv.r
## [ AUTH ] Benjamin Skinner (@btskinner)
## [ INIT ] 17 january 2020
##
################################################################################

## -- PURPOSE ------------------------------------------------------------------
##
## Function that will restructure a tibble for cross validation:
##
## INPUT: tibble of analysis-ready data
## ARGUMENTS: tbl_df, resampling method, appropriate arguments for method
## OUTPUT: tibble structured for cross validation
##
## NOTES:
## - using {rsample} from {tidymodels} framework
##
## -----------------------------------------------------------------------------

make_cv_df <- function(df,
                       tm_resample_method,
                       ...
                       ) {

    ## requires tidymodels; stop if not installed
    if (!require("rsample")) { stop("rsample not installed") }

    if (!is.character(tm_resample_method)) {
        ## convert if argument name not already a string...
        fun_name <- deparse(substitute(tm_resample_method))
    } else {
        ## ...else leave as is
        fun_name <- tm_resample_method
    }

    ## get function from tidymodels
    fun <- get(fun_name, asNamespace("rsample"))

    ## call argument with arguments
    fun(df, ...)

}
