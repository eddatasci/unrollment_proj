context("make_cv_df")
source("../../scripts/r/func_cv.r")

test_that("Cannot call sampling method with string", {

    expect_error(make_cv_df(mtcars, "bootstraps"), NA)
    expect_error(make_cv_df(mtcars, "initial_split"), NA)
    expect_error(make_cv_df(mtcars, "initial_time_split"), NA)
    expect_error(make_cv_df(mtcars, "loo_cv"), NA)
    expect_error(make_cv_df(mtcars, "mc_cv"), NA)
    expect_error(make_cv_df(mtcars, "rolling_origin"), NA)
    expect_error(make_cv_df(mtcars, "vfold_cv"), NA)

})

test_that("Cannot call sampling method without string", {

    expect_error(make_cv_df(mtcars, bootstraps), NA)
    expect_error(make_cv_df(mtcars, initial_split), NA)
    expect_error(make_cv_df(mtcars, initial_time_split), NA)
    expect_error(make_cv_df(mtcars, loo_cv), NA)
    expect_error(make_cv_df(mtcars, mc_cv), NA)
    expect_error(make_cv_df(mtcars, rolling_origin), NA)
    expect_error(make_cv_df(mtcars, vfold_cv), NA)

})

test_that("Cannot call sampling method with arguments", {

    expect_error(make_cv_df(mtcars, group_vfold_cv, cyl), NA)
    expect_error(make_cv_df(mtcars, group_vfold_cv, "cyl"), NA)
    expect_error(make_cv_df(mtcars, "group_vfold_cv", cyl), NA)
    expect_error(make_cv_df(mtcars, "group_vfold_cv", "cyl"), NA)

})

test_that("Sampling method with and without string not equal", {

    expect_equal(make_cv_df(mtcars, "initial_time_split"),
                 make_cv_df(mtcars, initial_time_split))


})

test_that("Sampling method not equal to calling tidymodel directly", {

    expect_equal(rsample::initial_time_split(mtcars),
                 make_cv_df(mtcars, initial_time_split))


})
