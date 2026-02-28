## This code prepares `tagging_proposals` dataset

proposals <- get_tagging_proposals(voting_summary = FALSE)

usethis::use_data(proposals, overwrite = TRUE)
