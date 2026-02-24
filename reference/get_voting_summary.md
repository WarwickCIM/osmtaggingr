# Scrape voting summary from tagging proposals

Given a vector of urls, scrapes the tagging proposals to retrieve voting
history data.

## Usage

``` r
get_voting_summary(urls)
```

## Arguments

- urls:

  a string containing the tagging proposal to retrieve details from.

## Value

a dataframe with some stats

## Examples

``` r
voting_history <- get_voting_history('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#> Error in get_voting_history("https://wiki.openstreetmap.org/wiki/Proposal:Electricity"): could not find function "get_voting_history"

voting_history
#> Error: object 'voting_history' not found
```
