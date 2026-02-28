#' OSM Tagging Proposals
#'
#' Metadata tagging proposals in [OSM Wiki](https://wiki.openstreetmap.org).
#' This dataset has been created by the script `data-raw/tagging_proposals.R`.
#'
#' This documentation is not yet complete: lacks all the final fields from the dataset.
#'
#' @format
#' A data frame with `r nrow(proposals)` rows and `r ncol(proposals)`
#' columns:
#' \describe{
#'   \item{id}{A unique identifier for every boundary}
#'   \item{service}{URL pointing to the API service}
#'   \item{url_download}{URL querying the API service to return all features as a geojson file}
#'
#' }
#'
#' @source <https://wiki.openstreetmap.org/wiki/Proposal_process>
"proposals"
