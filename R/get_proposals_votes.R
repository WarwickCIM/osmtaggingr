#' Scrape votes for tagging proposals
#'
#' Given a vector of urls, scrapes the tagging proposals to retrieve all the votes received.
#'
#' @param urls a string containing the tagging proposal to retrieve voting history from.
#'
#' @returns a dataframe with the following columns:
#' - `fullurl`: (string) the URL to the tagging proposal wiki page.
#' - `votes_raw`: (string) the raw text describing the vote.
#' - `vote`: (factor) vote (approve, abstain, oppose), inferred from the votes_raw text.
#' - `user`: (factor) voter's username.
#' - `date_vote`: (date) date in which the vote was cast.

#' @export
#'
#' @examples
#' proposal_votes <- get_proposals_votes('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#'
#' proposal_votes
#'
get_proposals_votes <- function(urls) {
  votes_df <- data.frame()
  pb <- cli::cli_progress_bar("Scraping proposals", total = length(urls))

  for (url in urls) {
    tmp_df <- NULL
    result <- tryCatch(
      {
        page <- rvest::read_html(url)
        li_votes <- page |>
          rvest::html_elements(xpath = "//*[@id='Voting']/following::ul/li") |>
          rvest::html_text2()

        tmp_df <- data.frame(
          url = url,
          votes_raw = li_votes
        ) |>
          dplyr::mutate(
            vote = dplyr::case_when(
              stringr::str_detect(
                votes_raw,
                "I approve this proposal"
              ) ~ "Approve",
              stringr::str_detect(
                votes_raw,
                "I oppose this proposal"
              ) ~ "Oppose",
              stringr::str_detect(
                votes_raw,
                "I have comments but abstain from voting on this proposal"
              ) ~ "Abstain"
            ),
            user = stringr::str_match(
              votes_raw,
              "[.\\-]\\s*([A-Za-z0-9 ]+)\\s*\\(talk\\)"
            )[, 2],
            user = stringr::str_remove_all(user, "-"),
            user = stringr::str_remove_all(user, "\\."),
            user = stringr::str_remove(user, "\\(talk\\)"),
            user = stringr::str_trim(user)
          ) |>
          dplyr::filter(!is.na(vote))
        tmp_df
      },
      error = function(e) {
        # If error, create a row with url and empty columns
        message(sprintf("Could not scrape %s: %s", url, e$message))
        data.frame(
          url = url,
          votes_raw = NA_character_,
          vote = NA_character_,
          user = NA_character_
        )
      }
    )

    votes_df <- dplyr::bind_rows(votes_df, result)
    cli::cli_progress_update()
    Sys.sleep(runif(1, min = 5, max = 30))
  }
  votes_df <- votes_df |>
    dplyr::mutate(
      vote = as.factor(vote),
      user = as.factor(user)
    ) |>
    tibble::as_tibble()

  cli::cli_progress_done()
  return(votes_df)
}
