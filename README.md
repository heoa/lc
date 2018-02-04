
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lc – List comprehension in R

[![Travis build
status](https://travis-ci.org/mailund/lc.svg?branch=master)](https://travis-ci.org/mailund/lc)
[![Coverage
Status](https://img.shields.io/codecov/c/github/mailund/lc/master.svg)](https://codecov.io/github/mailund/lc?branch=master)
[![Coverage
Status](https://coveralls.io/repos/github/mailund/lc/badge.svg?branch=master)](https://coveralls.io/github/mailund/lc?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

The goal of `lc` is to implement Haskell-like list comprehension in R.

## Installation

You can install lc from GitHub with:

``` r
install.packages("devtools")
devtools::install_github("mailund/lc")
```

## Example

FIXME

``` r
qsort <- function(lst) {
  n <- length(lst)
  if (n < 2) return(lst)
  
  pivot <- lst[[sample(n, size = 1)]]
  smaller <- Filter(function(x) x < pivot, lst)
  equal <- Filter(function(x) x == pivot, lst)
  larger <- Filter(function(x) x > pivot, lst)
  c(qsort(smaller), equal, qsort(larger))
}
(lst <- sample(1:10))
#>  [1] 10  1  7  9  2  4  6  5  3  8
unlist(qsort(lst))
#>  [1]  1  2  3  4  5  6  7  8  9 10
```
