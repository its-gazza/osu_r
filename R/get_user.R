#' Get player info
#'
#' \code{get_user} return a tibble dataframe with player's info
#'
#' @param user Username or user_id. If using user_id, need to set
#' \code{type} to \code{id}
#' @param api_key osu! API key
#' @param string Whether if user is a string
#' @param id Whether if user is and id
#' @param type Specify if user is \code{string} or \code{id}
#'
#' @export

get_user <- function(user,
                     api_key = NULL,
                     type = "string",
                     string = FALSE,
                     id = FALSE){
  # Determine user type
  if(string + id == 0){
    warning("No type specified")
    return()
  }
  if(string + id == 2){
    warning("Both string and id specified. Only choose one")
  }
  type <- ifelse(string, 'string', 'id')

  # Check API
  if(is.null(api_key)){
    warning("No API key supplied")
    return()
  }

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
    warning(glue::glue("User '{user}' is invalid with type '{type}'"))
    return()
  }

  # Convert data to propert class
  player_info <- get_info %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>%
    dplyr::select(
      dplyr::everything(),
      -events
    )

  return(player_info)
}
