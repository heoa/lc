
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lc – List comprehension in R

[![Travis build
status](https://travis-ci.org/mailund/lc.svg?branch=master)](https://travis-ci.org/mailund/lc)
[![AppVeyor Build
Status](https://ci.appveyor.com/mailund/lc)](https://ci.appveyor.com/api/projects/status/github//mailund/lc/?branch=master&svg=true)
[![Coverage
Status](https://img.shields.io/codecov/c/github/mailund/lc/master.svg)](https://codecov.io/github/mailund/lc?branch=master)
[![Coverage
Status](https://coveralls.io/repos/github/mailund/lc/badge.svg?branch=master)](https://coveralls.io/github/mailund/lc?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Depsy](http://depsy.org/api/package/cran/lc/badge.svg)](http://depsy.org/package/r/lc)

The goal of `lc` is to implement Haskell-like list comprehension in R.

## Installation

You can install lc from GitHub with:

``` r
install.packages("devtools")
devtools::install_github("mailund/lc")
```

## Examples

### Quick-sort

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
#>  [1]  5 10  6  3  8  2  1  9  7  4
unlist(qsort(lst))
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

``` r
qsort <- function(lst) {
  n <- length(lst)
  if (n < 2) return(lst)
  
  pivot <- lst[[sample(n, size = 1)]]
  smaller <- lc(x, x = lst, x < pivot)
  equal <- lc(x, x = lst, x == pivot)
  larger <- lc(x, x = lst, x > pivot)
  
  c(qsort(smaller), equal, qsort(larger))
}

(lst <- sample(1:10))
#>  [1]  6  8  3  2  4 10  5  9  7  1
unlist(qsort(lst))
#>  [1]  1  2  3  4  5  6  7  8  9 10
```
