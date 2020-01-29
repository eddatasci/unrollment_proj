context("Utility functions")
source("../../scripts/r/func_utils.r")

## ---------------------------
## quick paste functions
## ---------------------------

test_that("Pasting function not as expected: characters", {

    expect_equal("a" %+% "b", "ab")
    expect_equal("a" %_% "b", "a_b")
    expect_equal("a" %.% "b", "a.b")

})

test_that("Pasting function not as expected: numbers", {

    expect_equal("1" %+% "2", "12")
    expect_equal("1" %_% "2", "1_2")
    expect_equal("1" %.% "2", "1.2")

})

test_that("Pasting function not as expected: characters + numbers", {

    expect_equal("a" %+% "2", "a2")
    expect_equal("a" %_% "2", "a_2")
    expect_equal("a" %.% "2", "a.2")

})

test_that("Pasting function not equal to paste()", {

    expect_equal("a" %+% "b", paste("a", "b", sep = ""))
    expect_equal("a" %_% "b", paste("a", "b", sep = "_"))
    expect_equal("a" %.% "b", paste("a", "b", sep = "."))

})

## ---------------------------
## few_unique()
## ---------------------------

test_that("Incorrect truth value returned: numbers", {

    ## 5 unique values
    x <- rep(1:5, each = 5)
    expect_true(few_unique(x))
    expect_true(few_unique(x), 20)

    expect_false(few_unique(x, 4))
    expect_false(few_unique(x, 5))

    ## 20 unique values
    x <- rep(1:20, each = 5)
    expect_true(few_unique(x, 21))

    expect_false(few_unique(x))
    expect_false(few_unique(x, 20))

    ## 21 unique values
    x <- rep(1:21, each = 5)
    expect_true(few_unique(x, 22))

    expect_false(few_unique(x))
    expect_false(few_unique(x, 21))

})

test_that("Incorrect truth value returned: characters", {

    ## 5 unique values
    x <- rep(letters[1:5], each = 5)
    expect_true(few_unique(x))
    expect_true(few_unique(x, 20))

    expect_false(few_unique(x, 4))
    expect_false(few_unique(x, 5))

    ## 20 unique values
    x <- rep(letters[1:20], each = 5)
    expect_true(few_unique(x, 21))

    expect_false(few_unique(x))
    expect_false(few_unique(x, 20))

    ## 21 unique values
    x <- rep(letters[1:21], each = 5)
    expect_true(few_unique(x, 22))

    expect_false(few_unique(x))
    expect_false(few_unique(x, 21))

})
