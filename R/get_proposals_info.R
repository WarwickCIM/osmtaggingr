#' Scrape stats from tagging proposals
#'
#' Given a vector of urls, scrapes the tagging proposals to retrieve statistics and stores them into a dataframe.
#'
#' @param urls a string containing the tagging proposal to retrieve details from.
#' @param verbose a boolean to print the URL in the console.
#'
#' @returns a dataframe with some stats
#' @export
#'
#' @examples
#' proposals_info <- get_proposals_info('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#'
#' proposals_info
#'
get_proposals_info <- function(
  urls,
  verbose = FALSE
) {
  # Create empty dataframe to append details to it.
  proposals_info <- data.frame()

  for (url in urls) {
    if (verbose == TRUE) {
      print(url)
    }

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
      dplyr::mutate(across(starts_with("Date"), lubridate::dmy_hm)) |>
      dplyr::mutate(
        `Page creator` = stringr::str_remove_all(
          `Page creator`,
          ' \\(talk \\| contribs\\)'
        )
      ) |>
      dplyr::mutate(
        `Latest editor` = stringr::str_remove_all(
          `Latest editor`,
          " \\(.*\\)"
        )
      ) |>
      dplyr::mutate(url = url, .before = 1)

    proposal_history <- table_edit_history

    proposals_info <- proposals_info |>
      dplyr::bind_rows(proposal_history)
  }

  return(proposals_info)
}
