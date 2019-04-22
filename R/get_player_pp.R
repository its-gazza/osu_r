#' Get player pp info
#'
#' \code{get_player_pp} return a tibble dataframe with player's top 100 plays
#'
#' @param user Username or user_id. If using user_id, need to set
#' \code{type} to \code{id}
#' @param key osu! API key
#' @param type Specify if user is \code{string} or \code{id}
#' @param limit Amount of results. Default to max 100
#' @export

get_player_pp <- function(user,
                          type = "string",
                          key = key,
                          limit = 100){
  get_info <- GET(
    "https://osu.ppy.sh/api/get_user_best",
    query = list(k = key,
                 u = user,
                 limit = limit,
                 type = type)
  )

  # Check if the api key is correct
  if(get_info$status_code == 401){
    return(warning("Wrong API key"))
  }

  # Check if betamap id is correct
  if(content(get_info, as = "text") == "[]"){
    return(warning("Wrong User name/id"))
  }

  # Convert data to propert class
  pp_info <- get_info %>%
    content(as = "text") %>%
    fromJSON() %>%
    mutate(
      beatmap_id = as.character(beatmap_id),
      score = as.numeric(score),
      maxcombo = as.numeric(maxcombo),
      count50 = as.numeric(count50),
      count100 = as.numeric(count100),
      count300 = as.numeric(count300),
      countmiss = as.numeric(countmiss),
      countkatu = as.numeric(countkatu),
      countgeki = as.numeric(countgeki),
      enabled_mods = as.numeric(enabled_mods),
      date = as.POSIXct(date,
                        format = "%Y-%m-%d %H:%M:%S",
                        tz = "Asia/Hong_Kong"),
      pp = as.numeric(pp)
    )

  return(pp_info)
}
