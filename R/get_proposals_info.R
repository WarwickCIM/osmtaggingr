#' Scrape stats from tagging proposals
#'
#' Given a vector of urls, scrapes the tagging proposals to retrieve statistics and stores them into a dataframe.
#'
#' @param urls a string containing the tagging proposal to retrieve details from.
#'
#' @returns a dataframe with some stats
#' @export
#'
#' @examples
#' get_proposals_info('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#'
get_proposals_info <- function(
  urls
) {
  # Create empty dataframe to append details to it.
  proposals_stats <- data.frame()

  for (url in urls) {
    print(url)

    url_info <- paste0(url, "?action=info")

    tables <- rvest::read_html(url_info) |>
      rvest::html_elements("table") |>
      rvest::html_table()

    # Function to rearrange the date and time
    rearrange_datetime <- function(datetime_string) {
      stringr::str_replace(
        datetime_string,
        "^([0-9]{2}:[0-9]{2}), (.+)$",
        "\\2 \\1"
      )
    }

    table_edit_history <- tables[[3]] |>
      tidyr::pivot_wider(names_from = X1, values_from = X2) |>
      dplyr::mutate(across(starts_with("Date"), rearrange_datetime)) |>
      dplyr::mutate(across(starts_with("Date"), lubridate::dmy_hm))

    proposal_stats <- cbind(table_basic_info, table_edit_history)

    proposals_stats <- proposals_stats |>
      dplyr::bind_rows(proposal_stats)
  }

  return(proposals_stats)
}
