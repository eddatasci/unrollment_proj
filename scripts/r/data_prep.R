
library(tidyverse)
library(tidymodels)
library(workflows)
library(tune)


## top-level directory; everything else is relative to here
tldir <- file.path("..", "..")

## data directories
rddir <- file.path(tldir, "data", "raw")
cddir <- file.path(tldir, "data", "cleaned")

## figure directory
fgdir <- file.path(tldir, "figures")

## ELS student file: zip and rds
els_zip <- "ELS_2002-12_PETS_v1_0_Student_CSV_Datasets.zip"
els_url <- file.path("https://nces.ed.gov/EDAT/Data/Zip", els_zip)
els_rds <- "els.rds"


## quick paste functions
`%+%` <- function(a, b) paste(a, b, sep = "")   # a %+% b --> ab
`%_%` <- function(a, b) paste(a, b, sep = "_")  # a %_% b --> a_b
`%.%` <- function(a, b) paste(a, b, sep = ".")  # a %.% b --> a.b

## are unique values of x < n (default = 20) ? TRUE : FALSE
few_unique <- function(x, n = 20) { ifelse(length(unique(x)) < n, TRUE, FALSE) }

## does x %in% val ? NA : x
recode_missing <- function(x, val) { ifelse(x %in% val, NA, x) }

## ------------
## macros
## ------------

## unpack the ELS zip file regardless of whether RDS exists? TRUE : FALSE
unzip_again <- TRUE

## missing values used across ELS variables
## CAUTION: these are appropriate for variables we select, but may not
## be for all ELS variables; change as appropriate
els_missing_vals <- c(-1, -3, -4, -7,-8, -9)

## check if working (RDS) file exists
if (unzip_again || !file.exists(file.path(cddir, els_rds))) {
  ## ...if not, check if working (RDS) file exists
  if (!file.exists(file.path(rddir, els_zip))) {
    ## ...if not, download zip file from NCES
    download.file(url = els_url,
                  destfile = file.path(rddir, els_zip),
                  mode = "wb")
  }
  ## ...if so (or after download), unzip and munge
  df <- read_csv(file.path(rddir, els_zip)) %>%
    ## lower variable names
    rename_all(tolower)
  ## save for the future
#  saveRDS(df, file = file.path(cddir, els_rds))
} else {
  ## ...if exists, just read in
  df <- readRDS(file = file.path(cddir, els_rds))
}

## Variable naming conventions
## https://nces.ed.gov/pubs2014/2014364.pdf p. 128

els <- df %>%
  select_at(
    vars(
      stu_id,
      ## ID
      f2ps1sec,
      ## First Institution
      f3attainment,
      ## Outcome
      starts_with("by"),
      ## Base Year
      starts_with("f1"),
      ## First follow up
      starts_with("f2a"),
      ## Second follow up, hs vars
      starts_with("f2b")
      ## Second follow up, ps vars
    )
  ) %>% ## Second follow up, college vars
  select_if(negate ( ~ mean(.) == -5)) %>% ##Drop all suppressed vars
  select_at(vars(-matches("^([bf][y12][q])"))) %>% ## No questionnaire variables
  select_at(vars(-matches("[f[l?]g$"))) %>% ## No flag variables
  select_at(vars(-matches("wt$")))%>% ## No weight variables
  ## limit to students to started at four-year institutions
  filter(f2ps1sec %in% c(1:3)) %>% 
  ## recode missing values to proper NA
  mutate_all( ~ recode_missing(.x, els_missing_vals)) %>%
  ## create variable for completing a BA/BS
  mutate(ba_complete = ifelse(f3attainment %in% c(6,7,8,10), 1, 0))%>%
  ## identify factors and recode as, then lump to no more than 5
  mutate_if(~(n_distinct(.)<20),as.factor)%>%
  ## better factor levels for outcome
  mutate(ba_complete = recode_factor(ba_complete,
                                     "1" = "Completed",
                                     "0" = "Incomplete"))
  

        
