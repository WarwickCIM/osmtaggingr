# Scrape votes for tagging proposals

Given a vector of urls, scrapes the tagging proposals to retrieve all
the votes received.

## Usage

``` r
get_proposals_votes(urls)
```

## Arguments

- urls:

  a string containing the tagging proposal to retrieve voting history
  from.

## Value

a dataframe with the following columns:

- `fullurl`: (string) the URL to the tagging proposal wiki page.

- `votes_raw`: (string) the raw text describing the vote.

- `vote`: (factor) vote (approve, abstain, oppose), inferred from the
  votes_raw text.

- `user`: (factor) voter's username.

- `date_vote`: (date) date in which the vote was cast.

## Examples

``` r
proposal_votes <- get_proposals_votes('https://wiki.openstreetmap.org/wiki/Proposal:Electricity')

proposal_votes
#> # A tibble: 23 × 4
#>    url                                                     votes_raw vote  user 
#>    <chr>                                                   <chr>     <fct> <fct>
#>  1 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Luke 
#>  2 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Gaus…
#>  3 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Dr C…
#>  4 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I oppose… Oppo… NA   
#>  5 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Blen…
#>  6 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Mar …
#>  7 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I have c… Abst… Jona…
#>  8 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Nori…
#>  9 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Nanou
#> 10 https://wiki.openstreetmap.org/wiki/Proposal:Electrici… I approv… Appr… Andr…
#> # ℹ 13 more rows
```
