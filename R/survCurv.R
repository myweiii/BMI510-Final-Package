#' Calculate and plot a survival curve S(t) using given status and time data
#'
#' This function takes two numeric vectors: 'status' indicating the event occurrence and 'time'
#' indicating the time until the event or censoring occurs. It calculates and plots the survival
#' curve S(t).
#'
#' @param status Numeric vector indicating the occurrence of an event (1) or censoring (0).
#' @param time Numeric vector indicating the time to event or censoring.
#' @return A ggplot object representing the survival curve.
#' @importFrom stats dbinom prcomp sd
#' @importFrom dplyr mutate arrange
#' @importFrom ggplot2 aes geom_step labs theme_minimal ggplot
#' @importFrom tibble tibble
#' @examples
#' survCurv(status = c(1, 0, 1), time = c(5, 10, 15))
#' @export
survCurv <- function(status, time) {
  survival_data <- tibble(time = time, status = status) %>%
    arrange(time) %>%
    mutate(survival = rev(cumprod(rev(1 - status / sum(status)))))

  ggplot(survival_data, aes(x = time, y = survival)) +
    geom_step() +
    labs(x = "Time", y = "Survival Probability", title = "Survival Curve") +
    theme_minimal()
}
