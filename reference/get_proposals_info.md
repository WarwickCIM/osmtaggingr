# Scrape stats from tagging proposals

Given a vector of urls, scrapes the tagging proposals to retrieve
statistics and stores them into a dataframe.

## Usage

``` r
get_proposals_info(urls, verbose = FALSE)
```

## Arguments

- urls:

  a string containing the tagging proposal to retrieve details from.

- verbose:

  a boolean to print the URL in the console.

## Value

a dataframe with some stats

## Examples

``` r
proposals_info <- get_proposals_info('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#> 
#> ── Retrieving proposals' information ───────────────────────────────────────────

proposals_info
#>                                                        url  page_creator
#> 1 https://wiki.openstreetmap.org/wiki/Proposal:Electricity Privatemajory
#>   date_of_page_creation latest_editor date_of_latest_edit total_number_of_edits
#> 1   2018-09-03 15:51:00  TigerfellBot 2023-04-30 15:12:00                   220
#>   total_number_of_distinct_authors
#> 1                               53
```
