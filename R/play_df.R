#' Get player pp and bm info
#'
#' @param usr user name
#' @param key API key
#'
#' @export
#'
osu_get_player_full <- function(usr, key = key){
  player_info <- osur::osu_get_player(usr, key)
  player_pp <- osur::osu_get_player_pp(usr, key)
  player_bm_lst <- unique(player_pp$beatmap_id)
  player_bm <- NULL
  for(bm_info in player_bm_lst){
    tmp_info <- osu_get_beatmap(bm_info, key)
    player_bm <- bind_rows(player_bm, tmp_info)
  }
  mapply(osu_get_beatmap, player_bm_lst, key)

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
    mutate(mods = mapply(osu_detect_mod, enabled_mods),
           bpm = mapply(osu_convert_bpm, bpm, enabled_mods),
           total_length = mapply(osu_convert_total_length, total_length, enabled_mods),
           hit_length = mapply(osu_convert_hit_length, hit_length, enabled_mods),
           diff_size = mapply(osu_convert_size, diff_size, enabled_mods),
           diff_approach = mapply(osu_convert_ar, diff_approach, enabled_mods),
           diff_drain = mapply(osu_convert_drain, diff_drain, enabled_mods)
    )
  return(play_df)

}
