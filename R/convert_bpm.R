#' Title
#'
#' @param bpm
#' @param enabled_mods
#'
#' @return
#' @export
#'
#' @examples
convert_bpm <- function(bpm, enabled_mods){
  mod <- mod_detect(enabled_mods)
  if(str_detect(mod, "DT")){
    bpm = bpm * 3/2
  }
  if(str_detect(mod, "HT")){
    bpm = bpm * 3/4
  }
  return(bpm)
}
