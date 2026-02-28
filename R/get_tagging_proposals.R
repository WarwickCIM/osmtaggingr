#' Retrieve a list of tagging proposals
#'
#' Retrieves all tagging proposals in OSM's wiki by querying mediawiki's API and provides basic metadata.
#'
#' @param statuses a string or vector containing proposal's statuses to look for.
#' @param details boolean. Specifies whether to retrieve or not pages' details.
#' @param max_items a integer specifiying the the maximum number of members to retrieve for each category. Set to 5 by default.
#' @param info a boolean. Specifies whether to retrieve or not proposals' stats. Set TRUE by default.
#' @param voting_summary a boolean. Specifies whether to retrieve or not proposals' voting summary. Set TRUE by default.
#' @param file a string containing the file path to store the dataset.
#'
#' @returns a dataframe containing tagging proposals and associated metadata (see [`proposals`](proposals.html) for a description of its metadata).
#' @export
#'
#' @examples
#' proposals <- get_tagging_proposals("Proposed")
#' head(proposals)
#'
get_tagging_proposals <- function(
  statuses = c("Rejected", "Approved", "Proposed"),
  details = TRUE,
  max_items = 5,
  info = TRUE,
  voting_summary = TRUE,
  file = NULL
) {
  proposals_df <- data.frame(
    ns = integer(),
    title = character(),
    sortkeyprefix = character(),
    timestamp = character(),
    status = character()
  )

  for (status in statuses) {
    tmp_proposals <- WikipediR::pages_in_category(
      domain = "wiki.openstreetmap.org/",
      categories = paste0("Proposals with \"", status, "\" status"),
      type = "page",
      properties = c("title", "sortkeyprefix", "timestamp"),
      clean_response = TRUE,
      limit = max_items
    )

    # Store proposal's statuses.
    tmp_proposals$status = status

    # proposals.tmp <- bind_rows(proposals.tmp$query$categorymembers)

    proposals_df = rbind(proposals_df, tmp_proposals)

    # Some cleanup!
    rm(tmp_proposals)
  }

  # Remove pages that are not proposals per se, but a collection of proposals grouped by year.
  proposals_df = proposals_df |>
    dplyr::filter(stringr::str_starts(title, "Approved", negate = TRUE))

  if (details == TRUE) {
    # Create empty dataframe
    info_df <- data.frame(
      # int = integer(),
      ns = integer(),
      title = character(),
      contentmodel = character(),
      pagelanguage = character(),
      pagelanguagehtmlcode = character(),
      pagelanguagedir = character(),
      touched = character(),
      lastrevid = integer(),
      length = integer(),
      fullurl = character(),
      editurl = character(),
      canonicalurl = character()
    )

    for (i in 1:nrow(proposals_df)) {
      tmp_info <- WikipediR::page_info(
        domain = "wiki.openstreetmap.org/",
        page = proposals_df$title[i],
        properties = c("url"),
        clean_response = TRUE
      )

      if (length(tmp_info) != 0) {
        tmp_info <- dplyr::bind_rows(tmp_info[[1]])

        # if ("touched" %in% colnames(tmp_info) == FALSE) {
        #   tmp_info$touched <- NA
        # }
        #
        # tmp_info <- select(tmp_info,
        #                    # int,
        #                    ns, title,
        #                    contentmodel,
        #                    pagelanguage,
        #                    pagelanguagehtmlcode,
        #                    pagelanguagedir,
        #                    touched,
        #                    lastrevid,
        #                    length,
        #                    fullurl,
        #                    editurl,
        #                    canonicalurl)

        # info_df <- rbind(info_df, tmp_info)
        info_df <- dplyr::bind_rows(info_df, tmp_info)
      }
    }

    proposals_df <- proposals_df |>
      dplyr::select(-ns) |>
      dplyr::left_join(info_df, by = "title")
  }

  proposals_df <- tibble::as_tibble(proposals_df)

  if (info == TRUE) {
    proposals_info <- get_proposals_info(proposals_df$fullurl)

    proposals_df <- proposals_df |>
      dplyr::left_join(proposals_info, dplyr::join_by('fullurl' == 'url'))
  }

  if (voting_summary == TRUE) {
    voting_summary <- get_voting_summary(proposals_df$fullurl)

    proposals_df <- proposals_df |>
      dplyr::left_join(voting_summary, dplyr::join_by('fullurl' == 'url'))
  }

  if (!is.null(file)) {
    write.csv(proposals_df, file)
  }

  return(proposals_df)
}
