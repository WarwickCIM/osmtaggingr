#' Retrieve a list of tagging proposals
#'
#' Retrieves all tagging proposals in OSM's wiki by querying mediawiki's API and provides basic metadata.
#'
#' @param statuses a string or vector containing proposal's statuses to look for.
#' @param details boolean. Specifies whether to retrieve or not pages' details.
#' @param max_items a integer specifiying the the maximum number of members to retrieve for each category. Set to 5 by default.
#' @param stats a boolean. Specifies whether to retrieve or not proposals' stats. Set FALSE by default.
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
  stats = FALSE,
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

  if (details == TRUE) {
    # Create empty dataframe
    info_df <- data.frame(
      int = integer(),
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

  if (!is.null(file)) {
    write.csv(proposals_df, file)
  }

  return(proposals_df)
}


get_users_editing <- function(page_titles) {
  df <- data.frame()

  for (title in page_titles) {
    print(title)

    # Construct the API URL
    api_url <- paste0(
      "https://wiki.openstreetmap.org/w/api.php?action=query&prop=contributors&titles=",
      URLencode(title, reserved = TRUE),
      "&format=json"
    )

    # Query the API
    data <- jsonlite::fromJSON(api_url)

    # Extract contributors
    pages <- data$query$pages
    contributors <- NULL
    for (page in pages) {
      if (!is.null(page$contributors)) {
        contributors <- page$contributors
        break
      }
    }

    # Convert to data frame
    if (!is.null(contributors)) {
      tmp_df <- as.data.frame(contributors)
      tmp_df$page <- title
    }

    df <- rbind(tmp_df)
  }

  df <- tibble::as_tibble()(df)

  return(df)
}
