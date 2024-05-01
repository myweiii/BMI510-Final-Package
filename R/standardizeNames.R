#' Standardize Variable Names to Camel Case
#'
#' @description
#' A function to standardize variable names in a tibble to small camel case or
#' another specified case using `dplyr::rename_with` and `janitor::make_clean_names`.
#' The function relies on the `snakecase` package to format names into the chosen case.
#'
#' @param data A tibble whose variable names need to be standardized.
#' @param case_type The type of case to convert variable names into.
#'                  Default is 'small_camel'. Other options like 'big_camel', 'snake', etc.,
#'                  can be found in the documentation of the `snakecase::to_any_case` function.
#' @return A tibble with standardized variable names.
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr rename_with everything
#' @importFrom janitor make_clean_names
#' @importFrom snakecase to_any_case
#' @examples
#' df <- tibble::tibble(`Old Name1` = 1:10, `another name2` = letters[1:10])
#' new_df <- standardizeNames(df, 'small_camel')

standardizeNames <- function(data, case_type = 'small_camel') {
  data %>%
    rename_with(~ make_clean_names(.x) %>%
                  to_any_case(case = case_type), .cols = everything())
}
' One alternative function, without using snakecase:
standardizeNames <- function(data) {
  if (!inherits(data, "data.frame")) {
    stop("Input must be a tibble or data frame.")
  }
  data %>% rename_with(.fn = ~ make_clean_names(.) %>% sapply(FUN = convertToSmallCamelCase))
}

convertToSmallCamelCase <- function(name) {
  words <- unlist(strsplit(name, "_"))
  words <- tolower(words)
  words[-1] <- toupper(substr(words[-1], 1, 1)) %>% paste0(substr(words[-1], 2, nchar(words[-1])))
  paste0(words, collapse = "")
}'
