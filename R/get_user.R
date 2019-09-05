#' Get player info
#'
#' \code{get_user} return a tibble dataframe with player's info
#'
#' @param user Username or user_id. If using user_id, need to set
#' \code{type} to \code{id}
#' @param api_key osu! API key
#' @param type Specify if user is \code{string} or \code{id}
#' @export

get_user <- function(user,
                     api_key,
                     type = "string"){
  get_info <- httr::GET(url = "https://osu.ppy.sh/api/get_user",
                        query = list(k = api_key,
                                     u = user,
                                     type = type))

  # Check if request is good
  if(get_info$status_code == 401){
    warning(glue::glue("Incorrect API key: {api_key}"))
    return()
  }

  # Check if user id is correct
  if(httr::content(get_info, as = "text") == "[]"){
    warning(glue::glue("User: {user} is invalid"))
    return()
  }

  # Convert data to propert class
  player_info <- get_info %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>%
    dplyr::mutate(
      user_id = as.numeric(user_id),
      playcount = as.numeric(playcount),
      pp_rank = as.numeric(pp_rank),
      level = as.numeric(level),
      pp_raw = as.numeric(pp_raw),
      accuracy = round(as.numeric(accuracy, 4)),
      count_rank_ss = as.numeric(count_rank_ss),
      count_rank_ssh = as.numeric(count_rank_ssh),
      count_rank_s = as.numeric(count_rank_s),
      count_rank_sh = as.numeric(count_rank_sh),
      count_rank_a = as.numeric(count_rank_a),
      total_seconds_played = as.numeric(total_seconds_played),
      pp_country_rank = as.numeric(pp_country_rank),
      count300 = as.numeric(count300),
      count100 = as.numeric(count100),
      count50 = as.numeric(count50),
      ranked_score = as.numeric(ranked_score),
      total_score = as.numeric(total_score)) %>%
    dplyr::select(
      dplyr::everything(),
      -events
    )

  return(player_info)
}
