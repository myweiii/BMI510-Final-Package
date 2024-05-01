#' Calculate the minimum sample size needed for a t-test with specified power and significance level
#'
#' This function calculates the minimum number of observations needed to achieve a specified power
#' and significance level for a one-sample or two-sample t-test, depending on whether one or two
#' samples are provided.
#'
#' @param x1 Numeric vector representing the first sample.
#' @param x2 Optional numeric vector representing the second sample.
#' @return Minimum sample size needed for the specified statistical power.
#' @importFrom pwr pwr.t.test
#' @examples
#' minimumN(rnorm(10, mean = 0, sd = 1))
#' @export
minimumN <- function(x1, x2 = NULL) {
  if (is.null(x2)) {
    d <- abs(mean(x1)) / sd(x1)
  } else {
    n1 <- length(x1)
    n2 <- length(x2)
    pooled_sd <- sqrt(((n1 - 1) * sd(x1)^2 + (n2 - 1) * sd(x2)^2) / (n1 + n2 - 2))
    d <- abs(mean(x1) - mean(x2)) / pooled_sd
  }

  result <- pwr.t.test(d = d, power = 0.80, sig.level = 0.05,
                       type = if (is.null(x2)) "one.sample" else "two.sample",
                       alternative = "two.sided")

  return(ceiling(result$n))
}
