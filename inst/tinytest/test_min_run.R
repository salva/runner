set.seed(11)
x1 <- sample(c(1, 2, 3), 100, replace = TRUE)
x2 <- sample(c(NA, 1, 2, 3), 100, replace = TRUE)
k <- sample(1:100, 100, replace = TRUE)
lag <- sample(-15:15, 100, replace = TRUE)
idx <- cumsum(sample(c(1, 2, 3, 4), 100, replace = TRUE))
min2 <- function(x, na_rm = TRUE) {
  if (all(is.na(x))) return(NA) else min(x, na.rm = na_rm)
}

#        |--------]-------> -------
expect_identical(
  min_run(x2),
  runner(x2, f = min2)
)

expect_identical(
  min_run(x2, na_pad = TRUE),
  runner(x2, f = min2, na_pad = TRUE)
)

expect_identical(
  min_run(x2, na_rm = FALSE),
  runner(x2, function(x) min2(x, na_rm = FALSE))
)

#    [...|----]---+-------> -------
expect_equal(
  min_run(x2, lag = 3),
  runner(x2, lag = 3, f = min2))

expect_equal(
  min_run(x2, lag = 3, na_pad = TRUE),
  runner(x2, lag = 3, f = min2, na_pad = TRUE))

#        |--------+---]---> -------
expect_equal(
  min_run(x2, lag = -3),
  runner(x2, lag = -3, f = min2))

expect_equal(
  min_run(x2, lag = -3, na_pad = TRUE),
  runner(x2, lag = -3, f = min2, na_pad = TRUE))

#   [...]|--------+-------> -------
expect_equal(
  min_run(x2, lag = 100),
  suppressWarnings(runner(x2, lag = 100, f = min2, type = "numeric"))
)
expect_equal(
  min_run(x2, lag = 100, na_pad = TRUE),
  suppressWarnings(runner(x2, lag = 100, f = min2, na_pad = TRUE, type = "numeric"))
)

expect_equal(
  min_run(x2, lag = -100),
  suppressWarnings(runner(x2, lag = -100, f = min2, type = "numeric"))
)
expect_equal(
  min_run(x2, lag = -100, na_pad = TRUE),
  suppressWarnings(runner(x2, lag = -100, f = min2, na_pad = TRUE, type = "numeric"))
)

#        |----[...]-------> -------
expect_equal(
  min_run(x2, k = 3),
  runner(x2, k = 3, f = min2))

expect_equal(
  min_run(x2, k = 3, na_pad = TRUE),
  runner(x2, k = 3, f = min2, na_pad = TRUE))

#        [...|--------+-------[...] -------
expect_equal(
  min_run(x2, k = 1),
  runner(x2, k = 1, f = min2))

expect_equal(
  min_run(x2, k = 1, na_pad = TRUE),
  runner(x2, k = 1, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 99),
  runner(x2, k = 99, f = min2))

expect_equal(
  min_run(x2, k = 99, na_pad = TRUE),
  runner(x2, k = 99, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 100),
  runner(x2, k = 100, f = min2))

expect_equal(
  min_run(x2, k = 100, na_pad = TRUE),
  runner(x2, k = 100, f = min2, na_pad = TRUE))

#        [...|----]---+-------> -------
expect_equal(
  min_run(x2, k = 5, lag = 3),
  runner(x2, k = 5, lag = 3, f = min2))

expect_equal(
  min_run(x2, k = 5, lag = 3, na_pad = TRUE),
  runner(x2, k = 5, lag = 3, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 5, lag = 3, na_rm = FALSE),
  suppressWarnings(runner(x2, k = 5, lag = 3, f = min, type = "numeric"))
)

expect_equal(
  min_run(x2, k = 5, lag = 3, na_pad = TRUE, na_rm = FALSE),
  suppressWarnings(runner(x2, k = 5, lag = 3, f = min, na_pad = TRUE, type = "numeric"))
)

#        |-----[--+---]---> -------
expect_equal(
  min_run(x2, k = 5, lag = -3),
  runner(x2, k = 5, lag = -3, f = min2))

expect_equal(
  min_run(x2, k = 5, lag = -3, na_pad = TRUE),
  runner(x2, k = 5, lag = -3, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 5, lag = -3, na_rm = FALSE),
  runner(x2, k = 5, lag = -3, f = min))

expect_equal(
  min_run(x2, k = 5, lag = -3, na_pad = TRUE, na_rm = FALSE),
  suppressWarnings(runner(x2, k = 5, lag = -3, f = min, na_pad = TRUE, type = "numeric"))
)

#        |--------+-[---]-> -------
expect_equal(
  min_run(x2, k = 5, lag = -7),
  runner(x2, k = 5, lag = -7, f = min2))

expect_equal(
  min_run(x2, k = 5, lag = -7, na_pad = TRUE),
  runner(x2, k = 5, lag = -7, f = min2, na_pad = TRUE))


#        |--------+[]-----> -------
expect_equal(
  min_run(x2, k = 1, lag = -1),
  runner(x2, k = 1, lag = -1, f = min2))

expect_equal(
  min_run(x2, k = 1, lag = -1, na_pad = TRUE),
  runner(x2, k = 1, lag = -1, f = min2, na_pad = TRUE))

#        |------[]+-------> -------
expect_equal(
  min_run(x2, k = 1, lag = 1),
  runner(x2, k = 1, lag = 1, f = min2))

expect_equal(
  min_run(x2, k = 1, lag = 1, na_pad = TRUE),
  runner(x2, k = 1, lag = 1, f = min2, na_pad = TRUE))

# various -------
expect_equal(
  min_run(x2, k = k, lag = 1),
  runner(x2, k = k, lag = 1, f = min2))

expect_equal(
  min_run(x2, k = k, lag = 1, na_pad = TRUE),
  runner(x2, k = k, lag = 1, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, k = 3, lag = lag),
  runner(x2, k = 3, lag = lag, f = min2))

expect_equal(
  min_run(x2, k = 3, lag = lag, na_pad = TRUE),
  runner(x2, k = 3, lag = lag, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = k, lag = lag),
  runner(x2, k = k, lag = lag, f = min2))

expect_equal(
  min_run(x2, k = k, lag = lag, na_pad = TRUE),
  runner(x2, k = k, lag = lag, f = min2, na_pad = TRUE))

# date window -------
expect_equal(
  min_run(x2, lag = 3, idx = idx, na_pad = FALSE),
  runner(x2, lag = 3, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = 3, idx = idx, na_pad = TRUE),
  runner(x2, lag = 3, idx = idx, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, lag = -3, idx = idx, na_pad = FALSE),
  runner(x2, lag = -3, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = -3, idx = idx, na_pad = TRUE),
  runner(x2, lag = -3, idx = idx, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 3, idx = idx, na_pad = FALSE),
  runner(x2, k = 3, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, k = 3, idx = idx, na_pad = TRUE),
  runner(x2, k = 3, idx = idx, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, lag = -1, idx = idx, na_pad = FALSE),
  runner(x2, lag = -1, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = -1, idx = idx, na_pad = TRUE),
  runner(x2, lag = -1, idx = idx, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, lag = 100, idx = idx, na_pad = FALSE),
  runner(x2, lag = 100, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = 100, idx = idx, na_pad = TRUE),
  runner(x2, lag = 100, idx = idx, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, lag = -100, idx = idx, na_pad = FALSE),
  runner(x2, lag = -100, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = -100, idx = idx, na_pad = TRUE),
  runner(x2, lag = -100, idx = idx, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, lag = lag, idx = idx, na_pad = FALSE),
  runner(x2, lag = lag, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, lag = lag, idx = idx, na_pad = TRUE),
  runner(x2, lag = lag, idx = idx, f = min2, na_pad = TRUE))

expect_equal(
  min_run(x2, k = 3, lag = 4, idx = idx, na_pad = FALSE),
  runner(x2, k = 3, lag = 4, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, k = 3, lag = 4, idx = idx, na_pad = TRUE),
  runner(x2, k = 3, lag = 4, idx = idx, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, k = 3, lag = -4, idx = idx, na_pad = FALSE),
  runner(x2, k = 3, lag = -4, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, k = 3, lag = -4, idx = idx, na_pad = TRUE),
  runner(x2, k = 3, lag = -4, idx = idx, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, k = k, lag = -4, idx = idx, na_pad = FALSE),
  runner(x2, k = k, lag = -4, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, k = k, lag = -4, idx = idx, na_pad = TRUE),
  runner(x2, k = k, lag = -4, idx = idx, f = min2, na_pad = TRUE))


expect_equal(
  min_run(x2, k = 4, lag = lag, idx = idx, na_pad = FALSE),
  runner(x2, k = 4, lag = lag, idx = idx, f = min2, na_pad = FALSE))

expect_equal(
  min_run(x2, k = 4, lag = lag, idx = idx, na_pad = TRUE),
  runner(x2, k = 4, lag = lag, idx = idx, f = min2, na_pad = TRUE))
