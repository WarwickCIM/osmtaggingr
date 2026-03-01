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
  cli::cli_h1("Retrieving proposals' voting summaries")

  cli::cli_progress_bar("Webscraping", total = length(urls))

  df <- data.frame()

  for (url in urls) {
    vcard <- NULL
    result <- tryCatch(
      {
        page <- rvest::read_html(url)
        vcard_tbl <- page |>
          rvest::html_elements(".vcard") |>
          rvest::html_table()

        # Remove vcard that points to the feature page, if any.
        remove_feature_page <- function(
          lst,
          pattern = "The Feature Page for the",
          ignore.case = FALSE
        ) {
          idx <- vapply(
            lst,
            function(x) {
              txt <- paste(unlist(lapply(x, as.character)), collapse = " ")
              grepl(pattern, txt, fixed = TRUE, ignore.case = ignore.case)
            },
            logical(1)
          )
          lst[!idx]
        }

        # usage
        vcard_tbl <- remove_feature_page(vcard_tbl)
        vcard_tbl <- vcard_tbl[[1]]

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
        message(sprintf("Could not scrape %s : %s", url, e$message))
        NULL
      }
    )

    # Only bind if result is a data.frame and not NULL
    if (is.data.frame(result) && nrow(result) > 0) {
      df <- dplyr::bind_rows(df, result)
    }
    cli::cli_progress_update()
  }

  df <- df |>
    dplyr::mutate(
      proposal_status = as.factor(proposal_status),
      proposed_by = as.factor(proposed_by),
      applies_to = as.factor(applies_to),
      draft_started = lubridate::ymd(draft_started),
      rfc_start = lubridate::ymd(rfc_start),
      vote_start = lubridate::ymd(vote_start),
      vote_end = lubridate::ymd(vote_end)
    ) |>
    dplyr::select(dplyr::any_of(c(
      "url",
      "proposal_status",
      "proposed_by",
      "tagging",
      "applies_to",
      "definition",
      "statistics",
      "rendered_as",
      "draft_started",
      "rfc_start",
      "vote_start",
      "vote_end"
    )))

  cli::cli_progress_done()
  return(df)
}
