iclass <- function(x) {
  c(
    if (is.matrix(x)) "matrix",
    if (is.array(x) && !is.matrix(x)) "array",
    if (is.double(x) || is.integer(x)) "numeric",
    typeof(x)
  )
}
method_names <- function(generic, x) {
  paste0(generic, ".", c(class(x), iclass(x), "default"))
}
s3_dispatch <- function(call) {
  call <- substitute(call)
  generic <- as.character(call[[1]])
  object <- eval(call[[2]], parent.frame())
  methods <- method_names(generic, object)
  exists <- vapply(methods, exists, logical(1))
  cat(paste0(ifelse(exists, "*", " "), " ", methods, 
    collapse = "\n"), "\n", sep = "")
}



# Simple example ---------------------------------------------------------

x <- 1:10
class(x) <- c("c", "b", "a")

print.c <- function(x) {
  cat("C\n")
  NextMethod()
}
print(x)
s3_dispatch(print(x))

print.b <- function(x) {
  cat("B\n")
  NextMethod()
}
print(x)
s3_dispatch(print(x))


print.a <- function(x) {
  cat("A\n")
  NextMethod()
}

print(x)
s3_dispatch(print(x))


# Base R ----------------------------------------------------------------

x <- Sys.time()
s3_dispatch(print(x))
s3_dispatch(is.numeric(x))
s3_dispatch(as.Date(x))
