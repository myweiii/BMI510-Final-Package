#' Calculate the parameter p that maximizes the log-likelihood for Bernoulli distributed data
#'
#' This function takes a numeric vector consisting of 0s and 1s and calculates the value of p
#' that maximizes the log-likelihood of a Bernoulli distribution.
#'
#' @param data A numeric vector of 0s and 1s.
#' @return Numeric value of p that maximizes the log-likelihood.
#' @examples
#' logLikBernoulli(c(1, 0, 0, 0, 1, 1, 1))
#' @export
logLikBernoulli <- function(data) {
  max_v <- -Inf
  res_parameter <- NULL
  for (p in seq(0, 1, by = 0.001)) {
    loglikelihood <- sum(dbinom(data, size = 1, prob = p, log = TRUE))
    if (loglikelihood > max_v) {
      max_v <- loglikelihood
      res_parameter <- p
    }
  }
  return(res_parameter)
}
