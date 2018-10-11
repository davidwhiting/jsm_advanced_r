data("mpg", package = "ggplot2")

lm(hwy ~ class + displ, data = mpg)

boot_df <- function(x) x[sample(nrow(x), replace = T), ]
rsquared <- function(mod) summary(mod)$r.square

# In one step
vapply(1:500, function(i) {
  rsquared(lm(hwy ~ class + displ, data = boot_df(mpg)))
}, numeric(1))

# In several steps
bootstraps <- lapply(1:500, function(i) boot_df(mpg))
models <- lapply(bootstraps, function(df) lm(hwy ~ class + displ, data = df))
vapply(models, rsquared, numeric(1))


# In parallel ------------
library(parallel)
options(mc.cores = 4L)

# Linux and Mac
bootstraps <- mclapply(1:500, function(i) boot_df(mpg))

# Windows, Linux, and Mac
cluster <- makePSOCKcluster(4)
clusterExport(cluster, c("boot_df", "rsquared"))
bootstraps <- parLapply(cluster, 1:500, function(i) boot_df(mpg))

# Timings ----------

my_boot <- function(i) boot_df(mpg)

system.time(lapply(1:500, my_boot))

cluster <- makePSOCKcluster(2)
clusterExport(cluster, c("boot_df", "rsquared", "mpg"))
system.time(parLapply(cluster, 1:500, my_boot))
stopCluster(cluster)

cluster <- makePSOCKcluster(4)
clusterExport(cluster, c("boot_df", "rsquared", "mpg"))
system.time(parLapply(cluster, 1:500, my_boot))
stopCluster(cluster)

# Whole thing at once

boot_rsq <- function(i) {
  rsquared(lm(hwy ~ class + displ, data = boot_df(mpg)))
}
system.time(lapply(1:500, boot_rsq))

cluster <- makePSOCKcluster(2)
clusterExport(cluster, c("boot_df", "rsquared", "mpg"))
system.time(parLapply(cluster, 1:500, boot_rsq))
stopCluster(cluster)

cluster <- makePSOCKcluster(4)
clusterExport(cluster, c("boot_df", "rsquared", "mpg"))
system.time(parLapply(cluster, 1:500, boot_rsq))
stopCluster(cluster)
