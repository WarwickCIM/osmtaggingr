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

a dataframe with the following columns:

- `url`: the URL of the tagging proposal.

- `page_creator`: the username who created the page.

- `date_of_page_creation`: the date in which the page was created.

- `latest_editor`: the username who last edited the page.

- `date_of_latest_edit`: date in which the page was last updated.

- `total_number_of_edits`: number of total times that the page has been
  edited.

- `total_number_of_disctinct_authors`: number of distinct users who have
  edited the page.

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
