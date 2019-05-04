#' Convert size base on mods
#'
#' @param diff_size Beatmap difficulty
#' @param enabled_mods mods used
#'
#' @export
#'
osu_convert_size <- function(diff_size, enabled_mods){
  mod <- osu_detect_mod(enabled_mods)

  # Hard Rock
  if(str_detect(mod, "HR")){
    diff_size = min(diff_size * 1.3, 10)
  }
  # Easy
  if(str_detect(mod, "EZ")){
    diff_size = diff_size/2
  }
  return(diff_size)
}
