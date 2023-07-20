## https://noaadata.apps.nsidc.org/NOAA/G02135/south/daily/geotiff/2023/07_Jul/

time <- Sys.time()
YEAR <- format(time, "%Y")
MONTH <- format(time, "%m")
MNAME <- format(time, "%b")  ## assume locale is ok
hemi <- c("north", "south")
dir <- sprintf("https://noaadata.apps.nsidc.org/NOAA/G02135/%s/daily/geotiff/%s/%s_%s", hemi, YEAR, MONTH, MNAME)

tx <- lapply(dir, readLines)
south <- file.path(dir[2], gsub("^>", "", tail(na.omit(stringr::str_extract(tx[[2]], ">S_.*concentration.*tif")), 1)))
north <- file.path(dir[1], gsub("^>", "", tail(na.omit(stringr::str_extract(tx[[1]], ">N_.*concentration.*tif")), 1)))

dates <- as.Date(c(strptime(basename(north), "N_%Y%m%d"),
           strptime(basename(south), "S_%Y%m%d")))
if (!diff(as.integer(dates)) == 0) stop("different dates!!")

## date from file vs last date
if (!dates[1] > as.Date(readLines("data-raw/latestdate.txt", n = 1L)))) {
  #stop("no new data")
}
writeLines(format(dates[1]), "data-raw/latestdate.txt")
library(vapour)
#tm_ex <- c(-.5, .5, -1, 1) * 20025000
tm_ex <- c(-.3, .3, -.72, .72) * 20025000


file.rename("data-raw/seaice.png", "data-raw/old-seaice.png")


im <- gdal_raster_dsn(file.path("/vsicurl", c(north, south)),
                      target_res = 25000, target_crs = "+proj=tmerc +lon_0=147", target_ext = tm_ex,
                      out_dsn = "data-raw/seaice.tif")


system(sprintf("gdal_translate data-raw/seaice.tif data-raw/seaice.png -of PNG -expand RGB"))
