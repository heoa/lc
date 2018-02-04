context("lc")

test_that("We can do a simple map using lc", {
  x <- 1:5
  y <- unlist(lc(x ** 2, x = x))
  expect_equal(y, x ** 2)
})

test_that("We can filter elements using predicates", {
  x <- 1:10
  y <- x[x %% 2 == 0]
  z <- unlist(lc(x, x = x, x %% 2 == 0))
  expect_equal(y, z)
})
