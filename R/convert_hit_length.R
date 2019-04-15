#' Convert hit length base on mods
#'
#' @param hit_length Beatmap length
#' @param enabled_mods Mod used
#'
#' @export

convert_hit_length <- function(hit_length, enabled_mods){
  mod <- mod_detect(enabled_mods)
  if(str_detect(mod, "DT")){
    hit_length = hit_length * 3/2
  }
  if(str_detect(mod, "HT")){
    hit_length = hit_length * 3/4
  }
  return(hit_length)
}
