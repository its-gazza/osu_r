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
  if(get_info$status_code != 200){
    return(warnings(glue::glue("Error: Code {get_info$status_code}")))
  }
  # Check if beatmap id is valid
  if(is.null(content(get_info)[1][[1]])){
    return(warnings(glue::glue("Beatmap id {beatmap_id} is invalid")))
  }

  # Convert data to proper class
  bm_info <- get_info %>%
    httr::content(as = 'text') %>%
    jsonlite::fromJSON() %>%
    dplyr::as_tibble() %>%
    dplyr::mutate_at(vars(tidyselect::matches('diff|bpm|_count|length|playcount|count|combo')),
                     as.numeric) %>%
    dplyr::mutate_at(vars(contains('_date')),
                     as.POSIXct,
                     format = '%Y-%m-%d %H:%M:%S',
                     tz = "UTC")

  return(bm_info)
}
