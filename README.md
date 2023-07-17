
<!-- README.md is generated from README.Rmd. Please edit that file -->

# seaice.map

<!-- badges: start -->
<!-- [![R-CMD-check](https://github.com/mdsumner/seaice.map/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mdsumner/seaice.map/actions/workflows/R-CMD-check.yaml)-->
<!-- badges: end -->

The goal of seaice.map is to … display this image.

``` r
library(terra)
<<<<<<< HEAD
#> terra 1.7.41
r <- rast("data-raw/seaice.png")
plot(r, axes = F)
points(terra::project(do.call(cbind, maps::map(plot = F)[1:2]), to = terra::crs(r), from = "OGC:CRS84"), pch = ".", col = "#777777")
title(readLines("data-raw/latestdate.txt"))
=======
#> terra 1.7.39
plot(rast("data-raw/seaice.png"), axes = F)
>>>>>>> 8a368f4cafc75cfd61a4164afb612d1a290ed00f
```

<img src="man/figures/README-example-1.png" width="100%" />

This is 25km sea ice concentration from NSIDC, reprojected from images
published by NOAA at <https://noaadata.apps.nsidc.org/NOAA/G02135/> (the
projection is Transverse Mercator with central longitude 147).

Files in ‘data-raw/’ contain the actual metadata and scripts. This runs
as a daily task on github actions.

## Code of Conduct

Please note that the seaice.map project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
