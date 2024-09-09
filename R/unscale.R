#' Reverse the centering and scaling transformation applied to a vector
#'
#' This function takes a scaled vector and reverses the scaling and centering transformations
#' applied to it, returning the original vector.
#'
#' @param x A scaled numeric vector.
#' @return Numeric vector with reversed scaling and centering transformations.
#' @examples
#' x <- scale(1:10)
#' unscale(x)
#' @export
unscale <- function(x) {
  original_mean <- attr(x, "scaled:center")
  original_sd <- attr(x, "scaled:scale")

  if (!is.null(original_mean) && !is.null(original_sd)) {
    x <- x * original_sd + original_mean
  }
  else{
    print("Error in computing mean or sd! Some values are null")
    return(0)
    }
  return(x)
}
