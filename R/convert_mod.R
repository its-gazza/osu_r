
# Base on https://osu.ppy.sh/help/wiki/Game_Modifiers
# AR calc https://osu.ppy.sh/community/forums/topics/103810


convert_mod <- function(beatmap_id, enable_mod, key){
  # First we'll need to get the beatmap info
  bm_info <- get_beatmap(beatmap_id, key) %>%
    mutate(
      mods = ""
    )

  # Convert mod value to the relevant string
  mod_list <- mod_detect(enable_mod)

  # Hard Rock
  if(str_detect(mod_list, "HR")){
    bm_info %<>% mutate(
      diff_size = min(diff_size * 1.3, 10),
      diff_approach = min(diff_approach * 1.4, 10),
      diff_drain = min(diff_drain * 1.4, 10)
    )
  }

  # Easy
  if(str_detect(mod_list, "EZ")){
    bm_info %<>% mutate(
      diff_size = diff_size/2,
      diff_approach = diff_approach/2,
      diff_drain = diff_drain/2
    )
  }
  return(bm_info)

}




