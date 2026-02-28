# OSM Tagging Proposals

Metadata tagging proposals in [OSM
Wiki](https://wiki.openstreetmap.org). This dataset has been created by
the script `data-raw/tagging_proposals.R`.

## Usage

``` r
proposals
```

## Format

A data frame with 12 rows and 24 columns:

- id:

  A unique identifier for every boundary

- service:

  URL pointing to the API service

- url_download:

  URL querying the API service to return all features as a geojson file

## Source

<https://wiki.openstreetmap.org/wiki/Proposal_process>

## Details

This documentation is not yet complete: lacks all the final fields from
the dataset.
