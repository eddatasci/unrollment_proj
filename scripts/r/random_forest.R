## Running this the "workflows way"
## Will Doyle
## Trying to sort out the workflow/tune/dials way of doing this
## 2020-01-23

library(tidyverse)
library(tidymodels)
library(workflows)
library(tune)
library(vip)
library(glmnet)
library(doParallel)
library(ggridges)

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
results_rds <- "results.rds"


## ------------
## functionsg
## ------------

## quick paste functions
`%+%` <- function(a, b)
  paste(a, b, sep = "")   # a %+% b --> ab
`%_%` <- function(a, b)
  paste(a, b, sep = "_")  # a %_% b --> a_b
`%.%` <- function(a, b)
  paste(a, b, sep = ".")  # a %.% b --> a.b

## are unique values of x < n (default = 20) ? TRUE : FALSE
few_unique <-
  function(x, n = 20) {
    ifelse(length(unique(x)) < n, TRUE, FALSE)
  }

## does x %in% val ? NA : x
recode_missing <- function(x, val) {
  ifelse(x %in% val, NA, x)
}

## ------------
## macros
## ------------

## unpack the ELS zip file regardless of whether RDS exists? TRUE : FALSE
unzip_again <- FALSE

## missing values used across ELS variables
## CAUTION: these are appropriate for variables we select, but may not
## be for all ELS variables; change as appropriate
els_missing_vals <- c(-1,-3,-4,-8,-9)

## validation data set training proportion (between 0 and 1)
train_split <- 0.8

## bootstrap repetitions
boot_reps <- 100

## variables we want to select from full ELS dataset, also setting
## data type for faster input since ELS is much larger than we need
keepvars <- c(
  "STU_ID",
  # student id
  "STRAT_ID",
  # stratum id
  "PSU",
  # primary sampling unit
  "BYRACE",
  # (base year) race/ethnicity
  "BYINCOME",
  # (base year) parental income
  "BYPARED",
  # (base year) parental education
  "BYNELS2M",
  # (base year) math score
  "BYNELS2R",
  # (base year) reading score
  "F3ATTAINMENT",
  # (3rd follow up) attainment
  "F2PS1SEC"       # (2nd follow up) first institution attended
)

## check if working (RDS) file exists
if (unzip_again || !file.exists(file.path(cddir, els_rds))) {
  ## ...if not, check if working (RDS) file exists
  if (!file.exists(file.path(rddir, els_zip))) {
    ## ...if not, download zip file from NCES
    download.file(
      url = els_url,
      destfile = file.path(rddir, els_zip),
      mode = "wb"
    )
  }
  ## ...if so (or after download), unzip and munge
  df <- read_csv(file.path(rddir, els_zip)) %>%
    ## subset to variables in vector above
    select(one_of(keepvars)) %>%
    ## lower variable names
    rename_all(tolower)
  ## save for the future
  saveRDS(df, file = file.path(cddir, els_rds))
} else {
  ## ...if exists, just read in
  df <- readRDS(file = file.path(cddir, els_rds))
}


df <- df %>%
  ## limit to students to started at four-year institutions
  filter(f2ps1sec %in% c(1:3)) %>%
  ## recode missing values to proper NA
  mutate_all(~ recode_missing(.x, els_missing_vals)) %>%
  ## create variable for completing a BA/BS
  mutate(ba_complete = ifelse(f3attainment %in% c(6, 7, 8, 10), 1, 0))


## create analysis data
df_a <- df %>%
  ## select variables of interest
  select(ba_complete,
         starts_with("by")) %>%
  ## quickly identify and transform likely factor variables
  mutate_if(
    .,
    .predicate = function(x)
      few_unique(x),
    .funs = list(as_factor)
  ) %>%
  ## better factor levels for outcome
  mutate(ba_complete = recode_factor(ba_complete,
                                     "1" = "Completed",
                                     "0" = "Incomplete"))

## get vector of likely factors for later analysis
likely_factors <- df_a %>%
  select(-ba_complete) %>%
  select_if( ~ is.factor(.)) %>%
  names

## Formula
ba_complete_formula <- formula("ba_complete ~ .")

## Recipe

## Set recipe
grad_rec <- recipe(formula = ba_complete_formula)%>%
  step_naomit(all_predictors())%>%
  step_other(all_nominal(),threshold = .05)%>%
  step_dummy(all_nominal(),-ba_complete)

rec_training_set <- prep(grad_rec, training = df_a)

validation_data$recipes <- map(validation_data$splits, prepper, recipe = grad_rec)

## Set Model (This is the only thing that needs to vary)
grad_mod <-
  rand_forest(mode="classification",
              mtry= tune("Mtry"), 
              trees =tune("Trees"), 
              min_n =tune("Min N"))%>%
  set_engine("randomForest")

##Set Workflow
grad_wfl <-
  workflow() %>%
  add_recipe(grad_rec) %>%
  add_model(grad_mod)

## Take the prepped dataset and create resamples:
## How to do this within workflow?

prep_df_a<-prep(grad_rec)

juiced_df_a<-juice(prep_df_a)

## Temp: can expand
validation_data<-vfold_cv(juiced_df_a,v=2)

## Question: how to set control for max entropy approach

ctrl <- control_grid(save_pred=FALSE,verbose = TRUE,allow_par = TRUE)

## Generate Results

results_again = TRUE

if (results_again || !file.exists(file.path(cddir, results_rds))) {
  
  grad_res <- tune_grid(ba_complete_formula,
                        model=grad_mod,
                        control = ctrl,
                        resamples=validation_data)

  
  write_rds(grad_res, path = file.path(cddir, results_rds))
} else{
  grad_res <- read_rds(file.path(cddir, results_rds))
}


## Get AUC
roc_auc_vals <-
  collect_metrics(grad_res,summarize=FALSE) %>%
  filter(.metric == "roc_auc")


gg<-ggplot(roc_auc_vals,aes(x=.estimate,y=Mtry))
gg<-gg+geom_point()
gg

## Best results from tuning
grad_best <-
  select_best(grad_res, metric = "roc_auc", maximize = FALSE)

## Apply these best results to full dataset

## Prep
grad_rec_final <- prep(grad_rec)

##Grab parameter estimates
grad_mod_final <- finalize_model(grad_mod, grad_best)

## Apply best fit to full data
grad_fit <- grad_mod_final %>%
  fit(ba_complete_formula, data = juice(grad_rec_final))

## Model PLot
plot(grad_fit$fit)

## Variable importance plot
varImpPlot(grad_fit$fit)

## When parallelism goes wrong . . .
unregister <- function() {
  env <- foreach:::.foreachGlobals
  rm(list=ls(name=env), pos=env)
}