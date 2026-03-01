## This code prepares `tagging_proposals` dataset
library(osmtaggingr)

proposals <- get_tagging_proposals(max_items = 1000)

usethis::use_data(proposals, overwrite = TRUE)
