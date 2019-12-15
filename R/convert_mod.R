#' Convert AR
#'
#' Return converted AR given mod selected
#'
#' Hard Rock:
#'   * new ar = ar \* 1.4 (capped to 10)
#' Easy:
#'   * new ar = ar \\ 2
#'
#'
#' Half Time and Double Time's calculation is not as simple as Hard Rock or Easy
#' as it is dependent by its relevant ms
#'
#'
#'
#' @param ar Beatmap's original AR
#' @param enable_mod mod(s) used
#'
#' @examples
#' convert_ar(9,0) # No Mod
#' convert_ar(9, 256) # Half Time
#' @export
convert_ar <- function(ar, enable_mod){
  # Convert numeric mod to character mod
  mod_list <- osur::detect_mod(enable_mod)

  # HR and EZ are easy to calculate as it is universal among all AR
  if(stringr::str_detect(mod_list, "HR")){
    ar <- min(ar * 1.4, 10)
  }
  if(stringr::str_detect(mod_list, "EZ")){
    ar <- ar /2
  }

  # Convert AR to ms
  ms <- ifelse(ar < 5,
               1800 - ar * 120,
               1200 - (ar-5) * 150)

  # Convert HT and DT
  if(stringr::str_detect(mod_list, "HT")){
    ms <- ms * 4/3
  }
  if(stringr::str_detect(mod_list, "DT|NC")){
    ms <- ms * 2/3
  }

  # Reverse ms to AR
  ar <- ifelse(ms > 1200,
               (1800 - ms) / 120,
               (1200 - ms) / 150 + 5) %>%
    round(2)

  return(ar)

}



#' Convert BPM
#'
#' @param bpm Beatmap's original BPM
#' @param enabled_mods Mod(s) used
#'
#' @return Converted BPM
#' @export
convert_bpm <- function(bpm, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)
  if(stringr::str_detect(mod, "DT")){
    bpm = bpm * 3/2
  }
  if(stringr::str_detect(mod, "HT")){
    bpm = bpm * 3/4
  }
  return(bpm)
}


#' Convert drain
#'
#' @param diff_drain Drain difficulty
#' @param enabled_mods Mods used
#'
#' @export

convert_drain <- function(diff_drain, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)

  if(stringr::str_detect(mod, "HR")){
    diff_drain = min(diff_drain * 1.4, 10)
  }
  # Easy
  if(stringr::str_detect(mod, "EZ")){
    diff_drain = diff_drain/2
  }

  return(diff_drain)
}

# ======================================
#' Convert hit length base on mods
#'
#' @param hit_length Beatmap length
#' @param enabled_mods Mod used
#'
#' @export

convert_hit_length <- function(hit_length, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)
  if(stringr::str_detect(mod, "DT")){
    hit_length = hit_length * 3/2
  }
  if(stringr::str_detect(mod, "HT")){
    hit_length = hit_length * 3/4
  }
  return(hit_length)
}


#' Convert overall difficulrt
#'
#' @param diff_overall Beatmap overall difficulty
#' @param enabled_mods Mod used
#'
#' @export
convert_overall <- function(diff_overall, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)

  if(stringr::str_detect(mod, "HR")){
    diff_overall = min(diff_overall * 1.4, 10)
  }
  # Easy
  if(stringr::str_detect(mod, "EZ")){
    diff_overall = diff_overall/2
  }

  return(diff_overall)
}


#' Convert size base on mods
#'
#' @param diff_size Beatmap difficulty
#' @param enabled_mods mods used
#'
#' @export
#'
convert_size <- function(diff_size, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)

  # Hard Rock
  if(stringr::str_detect(mod, "HR")){
    diff_size = min(diff_size * 1.3, 10)
  }
  # Easy
  if(stringr::str_detect(mod, "EZ")){
    diff_size = diff_size/2
  }
  return(diff_size)
}


#' Convert total length base on mod
#'
#' @param total_length total length in beatmap
#' @param enabled_mods mod used
#'
#' @export
#'
convert_total_length <- function(total_length, enabled_mods){
  mod <- osur::detect_mod(enabled_mods)
  if(stringr::str_detect(mod, "DT")){
    total_length = total_length * 3/2
  }
  if(stringr::str_detect(mod, "HT")){
    total_length = total_length * 3/4
  }
  return(total_length)
}
