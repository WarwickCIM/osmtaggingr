#' Scrape voting summary from tagging proposals
#'
#' Given a vector of urls, scrapes the tagging proposals to retrieve voting history data.
#'
#' @param urls a string containing the tagging proposal to retrieve details from.
#'
#' @returns a dataframe with some stats
#' @export
#'
#' @examples
#' voting_summary <- get_voting_summary('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#'
#' voting_summary
#'
get_voting_summary <- function(urls) {
  cli::cli_progress_bar("Scraping proposals", total = length(urls))
  df <- data.frame()

  for (url in urls) {
    vcard <- NULL
    result <- tryCatch(
      {
        page <- rvest::read_html(url)
        vcard_tbl <- page |>
          rvest::html_element(".vcard") |>
          rvest::html_table()

        # Check if html_table returned a data.frame
        if (!is.data.frame(vcard_tbl)) {
          stop("No vcard table found")
        }

        vcard <- vcard_tbl |>
          dplyr::rename(variable = 1, value = 2) |>
          dplyr::mutate(
            variable = tolower(variable),
            variable = stringr::str_remove(variable, ":"),
            variable = stringr::str_replace(variable, " ", "_")
          ) |>
          tidyr::pivot_wider(names_from = variable, values_from = value) |>
          dplyr::mutate(url = url, .before = 1)

        vcard
      },
      error = function(e) {
        message(sprintf("Could not scrape %s: %s", url, e$message))
        NULL
      }
    )

    # Only bind if result is a data.frame and not NULL
    if (is.data.frame(result) && nrow(result) > 0) {
      df <- dplyr::bind_rows(df, result)
    }
    cli::cli_progress_update()
    Sys.sleep(runif(1, min = 2, max = 10))
  }

  cli::cli_progress_done()
  return(df)
}
