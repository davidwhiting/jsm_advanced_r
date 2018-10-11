# http://www.biostat.jhsph.edu/~rpeng/docs/R-debug-tools.pdf

# How do you debug warnings?

f <- function(x) {
  browser()
  x - g(x)
}
g <- function(y) {
  y * h(y)
}
h <- function(z) {
  r <- log(z)
  r ^ ifelse(r < 10, 2, 3)
}

plot(f, xlim = c(0, 5))
# 
# plot(f, xlim = c(-5, 5))
# options(warn = 2)
