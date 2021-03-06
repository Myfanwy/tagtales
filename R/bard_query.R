#' Execute a BARD query (http://cftc.metro.ucdavis.edu/biotelemetry-autonomous-real-time-database/fishtrack)
#'
#' @param tagIDs formatted like those returned from `prep_bardtags()`
#' @param dateStart start date of query, in YYYY-MM-DD format
#' @param dateEnd end date of query, in YYYY-MM-DD format; defaults to today
#' @param baseurl BARD query homepage
#' @param curlH curl handle; defaults to curl, which if you've run setup.R is in the global environment; running the following code will recreate it: \code{curl = getCurlHandle(useragent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36", followlocation = TRUE)}
#' @return a data frame of BARD detections; note that these detections are in a summarized format.
#' @author Matthew Espe
#' @export
#' @examples
#' \dontrun{
#' bard_query(tagIDS = bard_tags(c(2841, 2842)), curlH = getCurlHandle(useragent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36", followlocation = TRUE) )
#'}
bard_query = function(tagIDs,
                        dateStart = "2012-01-01", dateEnd = Sys.Date(),
                        baseurl = "http://sandbox5.metro.ucdavis.edu/memo/getTagCSV/",
                        curlH = getCurlHandle(useragent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36", followlocation = TRUE), ...)
{
    url = paste0(baseurl,
                 paste(tagIDs, collapse = ","), "/",
                 dateStart, "/", dateEnd)
    bq <- fromJSON(getURL(url, curl = curlH, ...))
    bq <- as.data.frame(data.table::rbindlist(bq))
}
