#' Get Beatmap info
#'
#' @param beatmap_id Beatmap id
#' @param api_key osu! api key
#'
#' @return tibble()
get_beatmap <- function(beatmap_id, api_key){
  get_info <- httr::GET(
    url = "https://osu.ppy.sh/api/get_beatmaps",
    query = list(k = api_key,
                 b = beatmap_id)
  )

  # Check if request is good
  if(get_info$status_code == 401){
    warning(glue::glue("Incorrect API key: {api_key}"))
    return()
  }
  # Check if beatmap id is valid
  if(httr::content(get_info, as = "text") == "[]"){
    warning(glue::glue("Beatmap id {beatmap_id} is invalid"))
    return()
  }

  # Convert data to proper class
  bm_info <- get_info %>%
    httr::content(as = 'text') %>%
    jsonlite::fromJSON() %>%
    dplyr::as_tibble() %>%
    dplyr::mutate_at(dplyr::vars(tidyselect::matches('diff|bpm|_count|length|playcount|count|combo')),
                     as.numeric) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains('_date')),
                     as.POSIXct,
                     format = '%Y-%m-%d %H:%M:%S',
                     tz = "UTC")

  return(bm_info)
}
