## Function enet class

#' Logistic regression via elastic net
#' 
#' @param fomula a formula
#' @param likely_factors a vector of characters, one for each of the likely fac
#' factors in the data
#' @param split data that has been structured for cross validation
#' @param depvar name of dependent variable, character
#' @param prog_bar name of progress object bar THIS IS BAD AND NEEDS TO NOT BE BAD 
#' @return a tibble of results, with columns id, truth, classifications results:
#' prediction of positive outcome, negative outcome, and probability of positive outcome
#' @example 



enet_class <- function(formula, likely_factors, split, id, depvar, prog_bar) {

  
  prog_bar$tick()$print()
  
  ## pull training (analysis) dataset from split
  analysis_set <- analysis(split)
  
  ## prep analysis dataset using recipe function above
  analysis_prep <- prep(recipe_function(analysis_set, 
                                        formula,
                                        likely_factors),
                        training = analysis_set)
  
  ## output model matrix and outcome
  analysis_processed <- bake(analysis_prep, new_data = analysis_set)
  
  penalized <- logistic_reg()
  ## fit logit regression (due to binary outcome)
  logit_fit <- logistic_reg(mixture = 0.1, penalty = 0.1,mode="classification") %>%
    set_engine("glmnet") %>%
    fit(formula = formula,
        data = analysis_processed)
  
  ## prep testing (assessment) dataset
  assessment_set <- assessment(split)
  
  ## prep assessment dataset using recipe function above
  assessment_prep <- prep(recipe_function(assessment_set,
                                          formula,
                                          likely_factors), 
                          testing = assessment_set)
  
  ## output model matrix and outcome
  assessment_processed <- bake(assessment_prep, new_data = assessment_set)
  
  ## return: output results as a tibble
  return(tibble("id" = id,
                "truth" = assessment_processed[[depvar]]) %>% ## THIS IS BAD AND SHOULD NOT BE BAD
           bind_cols(predict(logit_fit,
                             new_data = assessment_processed,
                             type = "prob")))%>%
    bind_cols(predict(logit_fit,
                      new_data = assessment_processed,
                      type = "class"))
}