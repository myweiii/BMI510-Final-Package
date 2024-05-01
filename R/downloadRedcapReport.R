#' Download a report from a REDCap project using API token and report ID
#'
#' This function uses the `httr::POST` method to download a specified report from a REDCap
#' project, utilizing an API token stored in the user's .REnviron file.
#'
#' @param redcapTokenName String name of the environment variable containing the REDCap API token.
#' @param redcapUrl String URL of the REDCap API endpoint.
#' @param redcapReportId Integer or string specifying the REDCap report ID to download.
#' @return Tibble containing the contents of the downloaded REDCap report.
#' @examples
#' Sys.setenv("testname" = "6189879441F5C29A25245880677488BF")
#' downloadRedcapReport("testname", "https://redcap.emory.edu/api/", "46524")
#' @export
downloadRedcapReport <- function(redcapTokenName, redcapUrl, redcapReportId) {
  print(redcapUrl)
  print(redcapReportId)
  token <- Sys.getenv(redcapTokenName)
  if (token == "") {
    stop("API token not found in .REnviron file.")
  }
  formData <- list(
    token = token,
    content = 'report',
    format = 'csv',
    report_id = as.character(redcapReportId),
    csvDelimiter = '',
    rawOrLabel = 'raw',
    rawOrLabelHeaders = 'raw',
    exportCheckboxLabel = 'false',
    returnFormat = 'csv'
  )
  response <- httr::POST(redcapUrl, body = formData, encode = "form")
  if (response$status_code != 200) {
    stop("Failed to download REDCap report. Status code: ", response$status_code)
  }
  result <- httr::content(response, type = "text", encoding = "UTF-8")
  return(readr::read_csv(result))
}

