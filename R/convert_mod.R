#' Convert difficulty base on mods
#' Base on: https://osu.ppy.sh/help/wiki/Game_Modifiers
#'
#' @param beatmap_id beatmap id
#' @param enable_mod Mod chosen, note this will take in numeric version of mod
#' @param key API key, used to get betamap info
#' @param df beatmap_df
#' @param method Which method we're using, could be id (Uses api) or df (R dataframe)
#'
#' @export
convert_mod <- function(beatmap_id, df, enable_mod, key, method = "id"){

  # First we'll need to get the beatmap info
  if(method == "id"){
    bm_info <- get_beatmap(beatmap_id, key) %>%
      mutate(
        mods = ""
      )
  } else if (method == "df"){
    bm_info <- df
  } else {
    return(warning("Method not specified"))
  }

  # Convert mod value to the relevant string
  mod_list <- mod_detect(enable_mod)

  # Alter difficulty base on mods
  # AR is handled at the end as the calculation is not straight forward
  # Hard Rock
  if(str_detect(mod_list, "HR")){
    bm_info %<>%
      mutate(
        diff_overall = min(diff_overall * 1.4, 10),
        diff_size = min(diff_size * 1.3, 10),
        diff_drain = min(diff_drain * 1.4, 10)
      )
  }
  # Easy
  if(str_detect(mod_list, "EZ")){
    bm_info %<>%
      mutate(
        diff_size = diff_size/2,
        diff_drain = diff_drain/2,
        diff_overall = diff_overall/2
      )
  }
  # DT
  if(str_detect(mod_list, "DT")){
    bm_info %<>%
      mutate(
        bpm = bpm * 3/2,
        hit_length = hit_length * 2/3,
        total_length = total_length * 2/3
      )
  }
  # Half Time
  if(str_detect(mod_list, "HT")){
    bm_info %<>%
      mutate(
        bpm = bpm * 3/4,
        hit_length = hit_length * 4/3,
        total_length = total_length * 4/3
      )
  }

  # AR convert
  bm_info %<>%
    mutate(
      diff_approach = convert_ar(diff_approach, enable_mod)
      )

  # Return info
  bm_info$enable_mode <- mod_list
  return(bm_info)
}
