
# finalPackage

<!-- badges: start -->
<!-- badges: end -->

`finalPackage` is an R package that provides advanced statistical functions ideal for biomedical research. These functions facilitate tasks ranging from analyzing Bernoulli distribution log-likelihoods to interacting with REDCap for data retrieval, alongside utilities for survival analysis and data transformation.

## Installation

You can install the released version of `finalPackage` from your GitHub repository using:

```R
# install.packages("devtools")
devtools::install_github("scarlett-duan/finalPackage")
```

## Functions

Here is a list of the primary functions available in `finalPackage`:

- `logLikBernoulli(data)`: Maximizes the log-likelihood for Bernoulli distributed data.
- `survCurv(status, time)`: Computes and plots a survival curve from given status and time data.
- `unscale(x)`: Reverses the centering and scaling transformations applied to data.
- `pcApprox(x, npc)`: Approximates data based on the number of principal components specified.
- `standardizeNames(data)`: Standardizes variable names in a dataset to "small camel" case.
- `minimumN(x1, x2)`: Calculates the minimum sample size required for a statistical power for t-tests.
- `downloadRedcapReport(redcapTokenName, redcapUrl, redcapReportId)`: Downloads and returns data from a specified REDCap report.

## Usage

Below are examples on how to use some of the key functions within `finalPackage`.

### 1. logLikBernoulli Function

This function calculates the parameter \( p \) that maximizes the log-likelihood for a series of Bernoulli trials. 

```R
# Example for logLikBernoulli
data_vector <- c(1, 0, 0, 0, 1, 1, 1)
estimated_p <- logLikBernoulli(data_vector)
print(estimated_p)
```

### 2. survCurv Function

Generates and plots a survival curve based on time-to-event data. 

```R
# Example for survCurv
status_vector <- c(1, 0, 1, 0, 1)  # 1 indicates an event occurred, 0 indicates censoring
time_vector <- c(1, 2, 3, 4, 5)
survival_plot <- survCurv(status_vector, time_vector)
print(survival_plot)
```

### 3. unscale Function

Reverses the centering and scaling transformations applied to a numeric vector, typically after it has been scaled.

```R
# Example for unscale
scaled_data <- scale(1:10)  # Scale a sequence of numbers
original_data <- unscale(scaled_data)
print(original_data)
```

### 4. pcApprox Function

This function returns an approximation of the original data based on the specified number of principal components.

```R
# Example for pcApprox
set.seed(123)  # For reproducibility
original_data <- matrix(rnorm(100), ncol = 10)
approx_data <- pcApprox(original_data, npc = 5)
print(approx_data)
```

### 5. standardizeNames Function

Converts all variable names in a dataset to "small camel" case or other specified formats using the `snakecase` package.

```R
# Example for standardizeNames
data_frame <- data.frame(`First Name` = c("Alice", "Bob"), `Last Name` = c("Smith", "Jones"))
standardized_data_frame <- standardizeNames(data_frame)
print(names(standardized_data_frame))
```

### 6. minimumN Function

Calculates the minimum number of observations required to achieve a specified statistical power for one-sample or two-sample t-tests.

```R
# Example for minimumN - One sample
sample_data_one <- rnorm(20, mean = 5, sd = 1)
min_n_one_sample <- minimumN(sample_data_one)
print(min_n_one_sample)

# Example for minimumN - Two samples
sample_data_two_1 <- rnorm(20, mean = 5, sd = 1)
sample_data_two_2 <- rnorm(20, mean = 5.5, sd = 1)
min_n_two_sample <- minimumN(sample_data_two_1, sample_data_two_2)
print(min_n_two_sample)
```

### 7. downloadRedcapReport Function

Downloads a report from a REDCap database using an API token, specified URL, and report ID. This function requires setting an environment variable for the token.

```R
# Example for downloadRedcapReport
# NOTE: You need to set up an API token in your environment variables before using this function.
Sys.setenv(REDCAP_TOKEN = "place_your_token_here")
redcap_report <- downloadRedcapReport("REDCAP_TOKEN", "https://redcap.emory.edu/api/", "46524")
print(redcap_report)
```

## Contributing

Contributions are welcome! If you'd like to contribute, please fork the repository and use a new branch for your contributions. Pull requests are warmly welcomed.

## Contact

If you have any questions, please feel free to contact Yuqing Duan at yuqing.duan@emory.edu.

## License

This project is licensed under the GPL-3 License. See the LICENSE file for more details.
```

### Notes
- **GitHub Repository**: You should replace `your-github-username` with your actual GitHub username to ensure users can find and install your package correctly.
- **Function Descriptions**: Provide brief but comprehensive descriptions of what each function does.
- **Contributions**: Encourage community contributions by clearly explaining how to contribute.
- **Contact Information**: Make sure to provide a way for users to reach you for support or questions about the package.
- **License**: Confirm the license under which you are releasing your package and ensure it is appropriately documented in your repository.
