# Copied from https://rpubs.com/deleeuw/262795 (09/10/26)
# Will not run until `jbkpava.c` is compiled into `jbkpava.so`
# You can do so with: `R CMD SHLIB jbkpava.c`

dyn.load("src/jbkpava/src/jbkpava.so")

jbkpava <- function(x, w = rep(1, length(x))) {
  h <-
    .C("jbkpava",
       x = as.double(x),
       w = as.double (w),
       n = as.integer(length(x)),
       PACKAGE = "jbkpava")
  (h$x)
}
