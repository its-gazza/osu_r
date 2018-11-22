#' Convert mod value to list of mods
#'
#' \code{mod_convert} converts enable_mod value to a list of character for selected mods
#' For full mod list see https://github.com/ppy/osu-api/wiki#mods?t
#'
#' @param value enable_mod value
#'
#' @export

mod_convert <- function(value){
  # Convert value to binary
  string <- intToBits(value)

  # If the value is just NC or PF they a  special value
  ## Night Core Only
  if(value == 576){
    return("NC")
  }
  ## Perfect Only
  if(value == 16416){
    return("PF")
  }

  # Set mod to Nil
  mod <- list()

  # NoFail
  if(string[[1]] == 1){
    mod <- c(mod, "NF")
  }

  # Easy
  if(string[[2]] == 1){
    mod <- c(mod, "EZ")
  }

  # Touch Device
  if(string[[3]] == 1){
    mod <- c(mod, "TD")
  }

  # Hidden
  if(string[[4]] == 1){
    mod <- c(mod, "HD")
  }

  # Hard Rock
  if(string[[5]] == 1){
    mod <- c(mod, "HR")
  }

  # Sudden Death
  if(string[[6]] == 1){
    mod <- c(mod, "SD")
  }

  # Double Time
  if(string[[7]] == 1){
    mod <- c(mod, "DT")
  }

  # Relax
  if(string[[8]] == 1){
    mod <- c(mod, "RX")
  }

  # Half Time
  if(string[[9]] == 1){
    mod <- c(mod, "HT")
  }

  # Night Core
  if(string[[10]] == 1){
    mod <- c(mod, "NC")
  }

  # Flashlight
  if(string[[11]] == 1){
    mod <- c(mod, "FL")
  }

  # Autoplay
  if(string[[12]] == 1){
    mod <- c(mod, "AP")
  }

  # Spun Out
  if(string[[13]] == 1){
    mod <- c(mod, "SO")
  }

  # Perfect
  if(string[[14]] == 1){
    mod <- c(mod, "PF")
  }

  # Return value
  ## Need to combine the list
  mod <- paste(mod, collapse = ",")
  return(mod)
}

