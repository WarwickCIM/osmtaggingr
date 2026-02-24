#' Retrieve a list of tagging proposals
#'
#' This function retrieves all tagging proposals in OSM's wiki by querying mediawiki's API
#'
#' @param statuses a string or vector containing proposal's statuses to look for.
#' @param details boolean. Specifies whether to retrieve or not pages' details. 
#' @param max_items a integer specifiying the the maximum number of members to retrieve for each category. Set to 5 by default.
#' @param file a string containing the file path to store the dataset.
#'
#' @returns a dataframe containing tagging proposals and associated metadata.
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
    file = NULL
  ) {
  
  proposals_df <- data.frame(ns = integer(),
                             title = character(),
                             sortkeyprefix = character(),
                             timestamp = character(),
                             status = character())
  
  for (status in statuses) {
    tmp_proposals <- WikipediR::pages_in_category(
      domain = "wiki.openstreetmap.org/",
      categories = paste0("Proposals with \"", status,"\" status"),
      type = "page",
      properties = c("title", "sortkeyprefix", "timestamp"),
      clean_response = TRUE,
      limit = max_items)
    
    # Store proposal's statuses.
    tmp_proposals$status = status
    
    # proposals.tmp <- bind_rows(proposals.tmp$query$categorymembers)
    
    proposals_df = rbind(proposals_df, tmp_proposals)
    
    # Some cleanup!
    rm(tmp_proposals)
  }
  
  
  if(details == TRUE) {
    
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
        tmp_info <- bind_rows(tmp_info[[1]])
        
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
        info_df <- bind_rows(info_df, tmp_info)
      }
      
      
    }
    
    
    proposals_df <- proposals_df |> 
      dplyr::select(-ns) |> 
      dplyr::left_join(info_df, by = "title")
  }
  
  if(!is.null(file)) {
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
  
  return(df)
  
}

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
    
    tryCatch({
      response <- httr::GET(api_url)
      if (httr::http_error(response)) stop("HTTP error")
      data <- jsonlite::fromJSON(httr::content(response, as = "text", encoding = "UTF-8"))
      
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
    }, error = function(e) {
      message(sprintf("Skipping '%s' due to error: %s", title, e$message))
    })
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



