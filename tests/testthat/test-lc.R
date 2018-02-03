context("lc")

test_that("We can do a simple map using lc", {
  x <- 1:5
  y <- unlist(lc(x**2, x = x))
  expect_equal(y, x**2)
})
