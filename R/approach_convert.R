




approach_convert <- function(ar, mod){

  delay <- ifelse(ar <= 5,
                  1800 - ar * 120,
                  1200 - (ar - 5) * 150)

  if(str_detect(mod, "HR")){
    delay <- max(delay * 2/3, 450)
  }
  if(str_detect(mod, "DT")){
    delay <- delay * 1/2
  }


  # Convert ar to delay
  if(!str_detect(mod, ",")){
    if(str_detect(mod, "EZ")){
      return(ar / 2)
    }
    if(str_detect(mod, "HR")){
      return(max(ar * 1.4, 10))
    }
  }



  if(str_detect(mod, "EZ")){
    delay <- delay *
  }
}
