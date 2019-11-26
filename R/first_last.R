#' Get first (minimum) and last (maximum) detection and stations of a tagged animal
#'
#' @param detdf A detections dataframe
#' @param tagidcol Name of the column (in quotes) corresponding to individual tag IDs
#' @param datetimecol Name of the column corresponding to detection date and time (must be in POSIXct ymd_hm/s format)
#' @param stationcol Name of the column corresponding to location or station information
#'
#' @return a dataframe with five columns: TagID, first_det (first detection of tag), first_stn (first station), last_det (last detection time at final station), last_stn (station where last arrival was recorded).
#' @author Myfanwy Johnston
#'@export
#'
first_last <- function(detdf, tagidcol = "TagID", datetimecol = "DateTimeUTC", stationcol = "Station"){

  detdf$Station = detdf[[stationcol]]
  detdf$datetimecol = detdf[[datetimecol]]
  detdf$TagID = detdf[[tagidcol]]

   do.call(rbind, lapply(split(detdf, detdf[detdf[[tagidcol]], ]), function(x) {

     x = x[order(x$datetimecol), ]

     return(data.frame(

       TagID = as.numeric(unique(x[x[[tagidcol]], ])),

       first_det = min(x$datetimecol),

       first_stn = x$Station[x$datetimecol == min(x$datetimecol)],

       last_det = max(x$datetimecol),

       last_stn = x$Station[x$datetimecol == max(x$datetimecol)],

       stringsAsFactors = FALSE)
     )
   }
   ))
 }
