
-   [Runner](#runner)
    -   [Installation](#installation)
    -   [Functionality](#functionality)

<!-- README.md is generated from README.Rmd. Please edit that file -->
Runner
======

[![Travis-CI Build Status](https://travis-ci.org/elo2zero/runner.svg?branch=master)](https://travis-ci.org/elo2zero/runner) [![MIT License](https://badges.frapsoft.com/os/mit/mit.svg)](https://opensource.org/licenses/mit-license.php) [![Coverage status](https://codecov.io/gh/elo2zero/runner/branch/master/graph/badge.svg)](https://codecov.io/github/elo2zero/runner?branch=master)

Running functions for R vector writen in Rcpp

Installation
------------

You can install runner from github with:

``` r
# install.packages("devtools")
devtools::install_github("elo2zero/runner")
```

Functionality
-------------

The main idea of the package is to provide running operations on R vectors. Running functions are these which are applied to all elements up to actual one. Typical example implemented already in `base` are `cumsum`, `cummean`, `cummin` etc. Functions provided in this package works similar but with extended functionality such as handling `NA` and custom window size.

``` r
library(runner)
set.seed(11)
x1 <- sample( c(1,2,3), 15, replace=TRUE)
x2 <- sample( c(NA,1,2,3), 15, replace=TRUE)
k  <- sample( 1:4, 15, replace=TRUE)

simple_min_run <- min_run(x1) # simple cumulative minimum
narm_min_run   <- min_run(x2, na_rm = TRUE) # cumulative minimum with removing NA.
kconst_min_run <- min_run(x2, na_rm = TRUE, k=4) # minimum in 4-element window
kvary_min_run  <- min_run(x2, na_rm = FALSE, k=k) # minimum in varying k window size
```
