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
voting_summary <- get_voting_summary('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')
#> 
#> ── Retrieving proposals' voting summaries ──────────────────────────────────────

voting_summary
#>                                                        url     proposal_status
#> 1 https://wiki.openstreetmap.org/wiki/Proposal:Electricity Rejected (inactive)
#>           proposed_by                           tagging applies_to
#> 1 Privatemajory, Luke electricity=yes, no, intermittent        , ,
#>                                                              definition
#> 1 Indicate the electricity source used in a public building or amenity.
#>   statistics  rendered_as draft_started  rfc_start vote_start   vote_end
#> 1            no rendering    2018-09-03 2020-10-15 2021-01-18 2021-02-01
```
