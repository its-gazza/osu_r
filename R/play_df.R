
#' Get player pp and bm info
#'
#' @param usr user name
#' @param key API key
#'
#' @export
#'
get_player_bm <- function(usr, key = key){
  player_info <- osur::get_player(usr, key)
  player_pp <- osur::get_player_pp(usr, key)
  player_bm_lst <- unique(player_pp$beatmap_id)
  player_bm <- NULL
  for(bm_info in player_bm_lst){
    tmp_info <- get_beatmap(bm_info, key)
    player_bm <- bind_rows(player_bm, tmp_info)
  }
    mapply(osur::get_beatmap, player_bm_lst, key)

  play_df <- player_pp %>%
    mutate(user_id = as.numeric(user_id),
           acc = map_acc(count50, count100, count300)) %>%
    inner_join(player_info %>%
                 select(user_id, username),
               by = "user_id") %>%
    inner_join(player_bm %>%
                 select(beatmap_id,
                        title,
                        artist,
                        bpm,
                        contains("length"),
                        contains("diff")),
               by = "beatmap_id") %>%
    mutate(mods = mapply(mod_detect, enabled_mods),
           bpm = mapply(convert_bpm, bpm, enabled_mods),
           total_length = mapply(convert_total_length, total_length, enabled_mods),
           hit_length = mapply(convert_hit_length, hit_length, enabled_mods),
           diff_size = mapply(convert_size, diff_size, enabled_mods),
           diff_approach = mapply(convert_ar, diff_approach, enabled_mods),
           diff_drain = mapply(convert_drain, diff_drain, enabled_mods)
    )
  return(play_df)

}
