#' Returns an approximation to the data based on the specified number of principal components
#'
#' This function performs PCA on the provided data matrix and returns an approximation of the
#' original data based on the specified number of principal components.
#'
#' @param x Numeric matrix or data frame.
#' @param npc Integer indicating the number of principal components to use.
#' @return Numeric matrix approximating the original data.
#' @examples
#' pcApprox(matrix(rnorm(100), ncol=10), npc=2)
#' @export
pcApprox <- function(x, npc) {
  if (npc > ncol(x)) {
    stop("Number of principal components exceeds the number of variables.")
  }

  centered_x <- scale(x, center = TRUE, scale = FALSE)
  pca <- prcomp(centered_x, scale. = FALSE)
  original_mean <- attr(centered_x, "scaled:center")
  approx <- pca$x[, 1:npc] %*% t(pca$rotation[, 1:npc])
  return(scale(approx, center = -original_mean, scale = FALSE))
}

