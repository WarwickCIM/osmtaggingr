## This code prepares `tagging_proposals` dataset
library(osmtaggingr)


# Tagging proposals -------------------------------------------------------

proposals <- get_tagging_proposals(max_items = 1000)

proposals <- proposals |>
  dplyr::mutate(
    applies_to_relation = dplyr::case_when(
      stringr::str_detect(tolower(applies_to), "relation") ~ TRUE,
      stringr::str_detect(tolower(applies_to), "all") ~ TRUE,
    ),
    .after = applies_to
  ) |>
  dplyr::mutate(
    applies_to_area = dplyr::case_when(
      stringr::str_detect(tolower(applies_to), "area") ~ TRUE,
      stringr::str_detect(tolower(applies_to), "all") ~ TRUE,
    ),
    .after = applies_to
  ) |>
  dplyr::mutate(
    applies_to_way = dplyr::case_when(
      stringr::str_detect(tolower(applies_to), "way") ~ TRUE,
      stringr::str_detect(tolower(applies_to), "all") ~ TRUE,
    ),
    .after = applies_to
  ) |>
  dplyr::mutate(
    applies_to_node = dplyr::case_when(
      stringr::str_detect(tolower(applies_to), "node") ~ TRUE,
      stringr::str_detect(tolower(applies_to), "all") ~ TRUE,
    ),
    .after = applies_to
  ) |>
  dplyr::select(-applies_to)

usethis::use_data(proposals, overwrite = TRUE)


# Proposals votes ---------------------------------------------------------

proposals_votes <- get_proposals_votes(proposals$fullurl)

usethis::use_data(proposals_votes, overwrite = TRUE)
