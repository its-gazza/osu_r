#' Convert hit length base on mods
#'
#' @param hit_length Beatmap length
#' @param enabled_mods Mod used
#'
#' @export

osu_convert_hit_length <- function(hit_length, enabled_mods){
  mod <- osu_detect_mod(enabled_mods)
  if(str_detect(mod, "DT")){
    hit_length = hit_length * 3/2
  }
  if(str_detect(mod, "HT")){
    hit_length = hit_length * 3/4
  }
  return(hit_length)
}
