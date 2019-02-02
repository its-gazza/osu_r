convert_drain <- function(diff_drain, enabled_mods){
  mod <- mod_detect(enabled_mods)

  if(str_detect(mod, "HR")){
    diff_drain = min(diff_drain * 1.4, 10)
  }
  # Easy
  if(str_detect(mod, "EZ")){
    diff_drain = diff_drain/2
  }

  return(diff_drain)
}
