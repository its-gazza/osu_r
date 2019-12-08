#' Calculate AR base on mod
#' This function calculate new AR base on mod
#'
#' @param enable_mod mod used
#' @param ar original AR
#'
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

