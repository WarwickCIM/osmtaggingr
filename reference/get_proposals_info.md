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

proposals_info
#>                                                        url  Page creator
#> 1 https://wiki.openstreetmap.org/wiki/Proposal:Electricity Privatemajory
#>   Date of page creation Latest editor Date of latest edit Total number of edits
#> 1   2018-09-03 15:51:00  TigerfellBot 2023-04-30 15:12:00                   220
#>   Total number of distinct authors Recent number of edits (within past 90 days)
#> 1                               53                                            0
#>   Recent number of distinct authors
#> 1                                 0
```
