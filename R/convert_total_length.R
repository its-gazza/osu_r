convert_total_length <- function(total_length, enabled_mods){
  mod <- mod_detect(enabled_mods)
  if(str_detect(mod, "DT")){
    total_length = total_length * 3/2
  }
  if(str_detect(mod, "HT")){
    total_length = total_length * 3/4
  }
  return(total_length)
}
