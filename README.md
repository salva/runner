<!-- rmarkdown v1 -->

<!-- README.md is generated from README.Rmd. Please edit that file -->
# `runner` an R package for running operations.
[![Travis-CI Build Status](https://travis-ci.org/gogonzo/runner.svg?branch=master)](https://travis-ci.org/gogonzo/runner)
[![Project Status](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![MIT License](https://badges.frapsoft.com/os/mit/mit.svg)](https://opensource.org/licenses/mit-license.php)
[![Coverage status](https://codecov.io/gh/gogonzo/runner/branch/master/graph/badge.svg)](https://codecov.io/github/gogonzo/runner?branch=master)

Running functions for R vector written in Rcpp

## Installation

You can install runner from github with:



## Examples
The main idea of the package is to provide running operations on R vectors. Running functions are these which are applied to all elements up to actual one. For example implemented already in `base` `cumsum`, `cummin` etc. Functions provided in this package works similar but with extended functionality such as handling `NA` and custom window size. Most functions provided in package are based on the same logic  
1. `k` window size denotes number of elements from i-th backwards, where functions are calculated.  
(obrazek pokazujący ruchome okno)
2. `na_rm` handling missing equivalent to `na.rm`. In case of running functions, `NA` is replaced with last finite value.  
3. `na_pad` if window size exceeds number of available elements, than first `k-1` are filled with `NA`.  
4. `which` In case of running index, which value ('first' or 'last')

### Creating windows
Function creates list of windows. Because `runner` provide limited functionality, one can create running-window-list which can be further computed to obtain desired statistic (eg. window sum). `x` is a vector to be 'windowed' and `k` is a length of window. In this example window length is varying as specified by `k`. Provide one value to obtain constant window size.


```r
library(runner)
library(magrittr)
set.seed(11)

x1 <- 1:5
k <- c(1,2,3,3,2)

window_run( x=x, k = k )
#> Error in window_run(x = x, k = k): length of k and length x differs. k=0 and k=length(x) only allowed
```

Such windows can be used in further calculations, with any R function. Example below shows how to obtain running `sum` in specified, varying window length (specified by `k`).


```r
window_run( x=x1, k = k ) %>%
  lapply(sum) %>%
  unlist
#> [1] 1 3 6 9 9
```
### Unique elements in window
One 

```r
x2 <- sample( letters[1:3], 6, replace=TRUE)
x2
#> [1] "a" "a" "b" "a" "a" "c"
unique_run( x=x2, k = 3 )
#> [[1]]
#> [1] "a"
#> 
#> [[2]]
#> [1] "a"
#> 
#> [[3]]
#> [1] "a" "b"
#> 
#> [[4]]
#> [1] "a" "b"
#> 
#> [[5]]
#> [1] "b" "a"
#> 
#> [[6]]
#> [1] "a" "c"
```

### Running aggregations

Runner provides basic aggregation method calculated within running windows. By default missing values are removed before calculations (`na_rm=TRUE`). 


```r
set.seed(11)
x <- rnorm( 30 ) %>% cumsum
x[c(5,6,10,11)] <- NA

k  <- sample( 2:5, 30, replace=TRUE)
```


#### min_run

```r
min1 <- min_run(x)
min2 <- min_run(x, k=4)
min3 <- min_run(x, k=k, na_rm = FALSE)
```

![plot of chunk plot_min_run](README-plot_min_run-1.png)

```

#### max_run

```r
max1 <- max_run(x)
max2 <- max_run(x, k=4)
max3 <- max_run(x, k=k, na_rm = FALSE)
```

#### mean_run

```r
mean1 <- mean_run(x)
mean2 <- mean_run(x, k=4)
mean3 <- mean_run(x, k=k, na_rm = FALSE)
```

#### sum_run

```r
sum1 <- sum_run(x)
sum2 <- sum_run(x, k=4)
sum3 <- sum_run(x, k=k, na_rm = FALSE)
```





### Running indexes

