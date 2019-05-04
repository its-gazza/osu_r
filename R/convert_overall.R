#' Convert overall difficulrt
#'
#' @param diff_overall Beatmap overall difficulty
#' @param enabled_mods Mod used
#'

#' @export

osu_convert_overall <- function(diff_overall, enabled_mods){
  mod <- osu_detect_mod(enabled_mods)

  if(str_detect(mod, "HR")){
    diff_overall = min(diff_overall * 1.4, 10)
  }
  # Easy
  if(str_detect(mod, "EZ")){
    diff_overall = diff_overall/2
  }

  return(diff_overall)
}
