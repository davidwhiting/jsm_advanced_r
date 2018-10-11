f <- function(x, y) g(x * y, y)
g <- function(x, y) j(y) + h(x)
h <- function(x) i(x - 5) * 2
i <- function(x) j(x) + 1
j <- function(x) {
  if (x < 0) {
    stop("`x` must be positive")
  }
  
  log(x)
}

f(10, 10)
f(2, 2)
f(10, -3)
