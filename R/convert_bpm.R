#' Convert BPM base on mod
#'
#' @param bpm beatmap bpm
#' @param enabled_mods Mods used
#'
#' @export
#'

osu_convert_bpm <- function(bpm, enabled_mods){
  mod <- osu_detect_mod(enabled_mods)
  if(str_detect(mod, "DT")){
    bpm = bpm * 3/2
  }
  if(str_detect(mod, "HT")){
    bpm = bpm * 3/4
  }
  return(bpm)
}
