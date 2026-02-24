get_users_editing <- function(page_titles) {
  results <- list()
  n <- length(page_titles)
  pb <- cli::cli_progress_bar("Querying pages", total = n)

  for (i in seq_along(page_titles)) {
    title <- page_titles[i]
    api_url <- paste0(
      "https://wiki.openstreetmap.org/w/api.php?action=query&prop=contributors&titles=",
      utils::URLencode(title, reserved = TRUE),
      "&format=json"
    )

    tryCatch(
      {
        response <- httr::GET(api_url)
        if (httr::http_error(response)) {
          stop("HTTP error")
        }
        data <- jsonlite::fromJSON(httr::content(
          response,
          as = "text",
          encoding = "UTF-8"
        ))

        pages <- data$query$pages
        contributors <- NULL
        for (page in pages) {
          if (!is.null(page$contributors)) {
            contributors <- page$contributors
            break
          }
        }
        if (!is.null(contributors)) {
          df <- as.data.frame(contributors)
          df$page_title <- title
          results[[length(results) + 1]] <- df
        }
      },
      error = function(e) {
        message(sprintf("Skipping '%s' due to error: %s", title, e$message))
      }
    )
    cli::cli_progress_update()
  }
  cli::cli_progress_done()

  # Combine all data frames into a single data frame
  if (length(results) > 0) {
    final_df <- do.call(rbind, results)
    rownames(final_df) <- NULL
    return(final_df)
  } else {
    return(data.frame())
  }
}
