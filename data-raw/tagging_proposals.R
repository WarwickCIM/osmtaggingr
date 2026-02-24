## This code prepares `tagging_proposals` dataset

proposals <- get_tagging_proposals()

usethis::use_data(tagging_proposals, overwrite = TRUE)
