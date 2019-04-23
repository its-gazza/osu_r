#' Get beatmap info
#'
#' \code{get_beatmap} return a tibble dataframe with the appropriate class
#'
#' @param beatmap_id Beatmap Id
#' @param key osu! API key
#' @export

get_beatmap <- function(beatmap_id, api_key = key){
  get_info <- GET(
    "https://osu.ppy.sh/api/get_beatmaps",
    query = list(k = api_key,
                 b = beatmap_id)
  )
  # Check if the api key is valid
  if(get_info$status_code == 401){
    return(warning("Invalid API key"))
  }

  # Check if betamap id is Valid
  if(content(get_info, as = "text") == "[]"){
    return(warning("Invalid beatmap id"))
  }

  # Convert data to propert class
  beatmap_info <- get_info %>%
    content(as = "text") %>%
    fromJSON() %>%
    mutate(
      total_length = as.numeric(total_length),
      hit_length = as.numeric(hit_length),
      diff_size = as.numeric(diff_size),
      diff_overall = as.numeric(diff_overall),
      diff_approach = as.numeric(diff_approach),
      diff_drain = as.numeric(diff_drain),
      approved_date = as.POSIXct(approved_date,
                                 format = "%Y-%m-%d %H:%M:%S",
                                 tz = "UTC"),
      last_update = as.POSIXct(last_update,
                               format = "%Y-%m-%d %H:%M:%S",
                               tz = "UTC"),
      bpm = as.numeric(bpm),
      favourite_count = as.numeric(favourite_count),
      playcount = as.numeric(playcount),
      passcount = as.numeric(passcount),
      max_combo = as.numeric(max_combo),
      difficultyrating = as.numeric(difficultyrating)
    )

  return(beatmap_info)
}
