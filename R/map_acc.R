#' Calculate map accuracy
#'
#' \code{map_acc} Calcualtes the map accuracy base on number of 300, 100 and 50s.
#' Calculation base on https://osu.ppy.sh/help/wiki/Accuracy
#'
#' @param count50 Total number of 50s
#' @param count100 Total number of 100s
#' @param count300 Total number of 300s
#' @export
map_acc <- function(count50, count100, count300){
  accuracy <- (50*count50 + 100*count100 + 300*count300)/
      (300*(count50 + count100 + count300)) * 100
  return(round(accuracy, 2))
}
