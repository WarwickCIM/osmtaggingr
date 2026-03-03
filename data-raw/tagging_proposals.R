## This code prepares `tagging_proposals` dataset
library(osmtaggingr)


# Tagging proposals -------------------------------------------------------

proposals <- get_tagging_proposals(max_items = 1000)

proposals_inactive <- get_tagging_proposals(
  statuses = c(
    "Draft",
    "Voting",
    "Abandoned",
    "Canceled",
    "Obsoleted",
    "Inactive"
  ),
  max_items = 1000
)

proposals <- proposals |>
  dplyr::bind_rows(proposals_inactive)

usethis::use_data(proposals, overwrite = TRUE)


# Proposals votes ---------------------------------------------------------

proposals_votes <- get_proposals_votes(proposals$fullurl)

usethis::use_data(proposals_votes, overwrite = TRUE)
