#' Convert total length base on mod
#'
#' @param total_length total length in beatmap
#' @param enabled_mods mod used
#'
#' @export
#'
convert_total_length <- function(total_length, enabled_mods){
  mod <- osu_detect_mod(enabled_mods)
  if(str_detect(mod, "DT")){
    total_length = total_length * 3/2
  }
  if(str_detect(mod, "HT")){
    total_length = total_length * 3/4
  }
  return(total_length)
}
