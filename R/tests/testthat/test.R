# 1
test_that("Test logLikBernoulli", {
  data <- c(1,0,0,0,1,1,1)
  result <- logLikBernoulli(data)
  expect_true(is.numeric(result))
  expect_true(result >= 0 && result <= 1)
})


# 2
temp_file <- tempfile()
download.file("https://jlucasmckay.bmi.emory.edu/global/bmi510/Labs-Materials/survival.csv", temp_file, mode = "wb")
survival_data <- read_csv(temp_file)
survCurv(survival_data$status, survival_data$time)


# 3
test_that("Test unscale", {
  x <- scale(1:10)
  original <- 1:10
  unscaled <- unscale(x)
  expect_equal(as.numeric(unscaled), original, tolerance = 1e-8)
})


# 4
test_that("Test pcApprox", {
  x <- matrix(rnorm(100), ncol = 10)
  npc <- 5
  approx <- pcApprox(x, npc)
  expect_true(is.matrix(approx))
  expect_equal(dim(approx), dim(x))
})


# 5
test_that("Test standardizeNames", {
  data <- tibble(`First Name` = c("Alice", "Bob"), `Last Name` = c("Smith", "Jones"))
  standardized <- standardizeNames(data)
  expect_true("firstName" %in% names(standardized))
  expect_true("lastName" %in% names(standardized))
})


# 6
test_that("minimumN returns correct value for single sample", {
  set.seed(123)
  sample_data <- rnorm(20, mean = 5, sd = 1)
  expected_n <- ceiling(pwr.t.test(d = abs(mean(sample_data)) / sd(sample_data),
                                   power = 0.80,
                                   sig.level = 0.05,
                                   type = "one.sample",
                                   alternative = "two.sided")$n)
  expect_equal(minimumN(sample_data), expected_n)
})

test_that("minimumN returns correct value for two samples", {
  set.seed(123)
  sample_data1 <- rnorm(20, mean = 5, sd = 1)
  sample_data2 <- rnorm(20, mean = 5.5, sd = 1)
  n1 <- length(sample_data1)
  n2 <- length(sample_data2)
  pooled_sd <- sqrt(((n1 - 1) * sd(sample_data1)^2 + (n2 - 1) * sd(sample_data2)^2) / (n1 + n2 - 2))
  d <- abs(mean(sample_data1) - mean(sample_data2)) / pooled_sd
  expected_n <- ceiling(pwr.t.test(d = d,
                                   power = 0.80,
                                   sig.level = 0.05,
                                   type = "two.sample",
                                   alternative = "two.sided")$n)
  expect_equal(minimumN(sample_data1, sample_data2), expected_n)
})


# 7
test_that("Test downloadRedcapReport", {
  Sys.setenv("testname" = "6189879441F5C29A25245880677488BF")
  result <- downloadRedcapReport("testname", "https://redcap.emory.edu/api/", "46524")
  expect_true(is_tibble(result))
  expect_true(ncol(result) > 0)
  expect_true(nrow(result) > 0)
})

