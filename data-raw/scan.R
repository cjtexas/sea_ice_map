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
if (file.exists("data-raw/latestdate.txt")) {
if (!dates[1] > as.Date(readLines("data-raw/latestdate.txt", n = 1L))) {
  stop("no new data")
}
}
