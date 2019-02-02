



convert_overall <- function(diff_overall, enabled_mods){
  mod <- mod_detect(enabled_mods)

  if(str_detect(mod, "HR")){
    diff_overall = min(diff_overall * 1.4, 10)
  }
  # Easy
  if(str_detect(mod, "EZ")){
    diff_overall = diff_overall/2
  }

  return(diff_overall)
}
