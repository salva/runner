
`runner` a R package for running operations.
============================================

<img src="man/figures/hexlogo.png" align="right" />
===================================================

[![Cran badge](https://cranlogs.r-pkg.org/badges/runner)](https://CRAN.R-project.org/package=runner) [![Travis-CI Build Status](https://travis-ci.org/gogonzo/runner.svg?branch=master)](https://travis-ci.org/gogonzo/runner) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/gogonzo/runner?branch=master&svg=true)](https://ci.appveyor.com/project/gogonzo/runner) ![Coverage status](https://codecov.io/gh/gogonzo/runner/branch/master/graph/badge.svg)

About
-----

Package contains standard running functions (aka. windowed, rolling, cumulative) with additional options. `runner` provides extended functionality like date windows, handling missings and varying window size. `runner` brings also rolling streak and rollin which, what extends beyond range of functions already implemented in R packages.

Installation
------------

Install package from from github or from CRAN.

``` r
# devtools::install_github("gogonzo/runner")
install.packages("runner")
```

Using runner
------------

`runner` package provides functions applied on running windows. Diagram below illustrates what running windows are - in this case running `k = 4` windows. For each of 15 elements of a vector each window contains current 4 elements (exception are first k - 1 elements where window is not complete).

![](man/figures/running_windows_explain.png)

Using `runner` one can apply any R function `f` in running window of length defined by `k`, window `lag`, observation indexes `idx`.

![](man/figures/using_runner.png)

### Window size

`k` denotes number of elements in window. If `k` is a single value then window size is constant for all elements of x. For varying window size one should specify `k` as integer vector of `length(k) == length(x)` where each element of `k` defines window length. If `k` is empty it means that window will be cumulative (like `base::cumsum`). Example below illustrates window of `k = 4` for 10'th element of vector `x`.

![](man/figures/constant_window.png)

### Window lag

`lag` denotes how many observations windows will be lagged by. If `lag` is a single value than it's constant for all elements of x. For varying lag size one should specify `lag` as integer vector of `length(lag) == length(x)` where each element of `lag` defines lag of window. Default value of `lag = 0`. Example below illustrates window of `k = 4` lagged by `lag = 2` for 10'th element of vector `x`. Lag can also be negative value, which shifts window forward instead of backward.

![](man/figures/lagged_window_k_lag.png)

### Windows depending on date

Sometimes data points in dataset are not equally spaced (missing weeekends, holidays, other missings) and thus window size should vary to keep expected time frame. If one specifies `idx` argument, than running functions are applied on windows depending on date. `idx` should be the same length as `x` of class `Date` or `integer`. Including `idx` can be combined with varying window size, than k will denote number of periods in window different for each data point. Example below illustrates window of size `k = 4` lagged by `lag = 2` periods for 10'th element of vector `x`. This (10th) element has `idx = 13` which means that window ranges `[8, 11]` - although `k = 4` only two elements of `x` are within this window.

![](man/figures/custom_idx_k_lag.png)

### Build-in functions

With `runner` one can use any R functions, but some of them are optimized for speed reasons. These functions are:
- aggregating functions - `length_run`, `min_run`, `max_run`, `minmax_run`, `sum_run`, `mean_run`, `streak_run`
- utility functions - `fill_run`, `lag_run`, `which_run`

Simple example
--------------

14-days trimmed mean

``` r
library(runner)
x <- rnorm(20)
date <- seq.Date(Sys.Date(), Sys.Date() + 19, by = "1 day")
runner(x, k = 14, idx = date, f = function(xi) mean(xi, na.rm = TRUE, trim = 0.05))
```

    ##  [1] -0.1293755 -0.4648944 -0.3256400 -0.2073942 -0.5131102 -0.6672929
    ##  [7] -0.7305670 -0.5624326 -0.5527821 -0.5268286 -0.5222003 -0.6448387
    ## [13] -0.6788169 -0.6780393 -0.6077265 -0.6590736 -0.6990439 -0.7927854
    ## [19] -0.5330058 -0.5263309
