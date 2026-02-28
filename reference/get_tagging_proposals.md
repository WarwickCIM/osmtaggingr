# Retrieve a list of tagging proposals

Retrieves all tagging proposals in OSM's wiki by querying mediawiki's
API and provides basic metadata.

## Usage

``` r
get_tagging_proposals(
  statuses = c("Rejected", "Approved", "Proposed"),
  details = TRUE,
  max_items = 5,
  info = TRUE,
  voting_summary = TRUE,
  file = NULL
)
```

## Arguments

- statuses:

  a string or vector containing proposal's statuses to look for.

- details:

  boolean. Specifies whether to retrieve or not pages' details.

- max_items:

  a integer specifiying the the maximum number of members to retrieve
  for each category. Set to 5 by default.

- info:

  a boolean. Specifies whether to retrieve or not proposals' stats. Set
  TRUE by default.

- voting_summary:

  a boolean. Specifies whether to retrieve or not proposals' voting
  summary. Set TRUE by default.

- file:

  a string containing the file path to store the dataset.

## Value

a dataframe containing tagging proposals and associated metadata (see
[`proposals`](https://warwickcim.github.io/osmtaggingr/reference/proposals.md)
for a description of its metadata).

## Examples

``` r
proposals <- get_tagging_proposals("Proposed")
#> Scraping proposals ■■■■■■■■■■■■■                     40% | ETA:  5s
#> Scraping proposals ■■■■■■■■■■■■■■■■■■■               60% | ETA:  7s
#> Scraping proposals ■■■■■■■■■■■■■■■■■■■■■■■■■         80% | ETA:  4s
#> Scraping proposals ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
head(proposals)
#> # A tibble: 5 × 33
#>   title           sortkeyprefix timestamp status    ns contentmodel pagelanguage
#>   <chr>           <chr>         <chr>     <chr>  <int> <chr>        <chr>       
#> 1 Proposal:3D ta… 3D tagging f… 2025-09-… Propo…  3000 wikitext     en          
#> 2 Proposal:Note … :note suffix  2022-07-… Propo…  3000 wikitext     en          
#> 3 Proposal:Acces… access_key    2024-10-… Propo…  3000 wikitext     en          
#> 4 Proposal:Add l… Add language… 2024-11-… Propo…  3000 wikitext     en          
#> 5 Proposal:Addr:… addr:interpo… 2022-03-… Propo…  3000 wikitext     en          
#> # ℹ 26 more variables: pagelanguagehtmlcode <chr>, pagelanguagedir <chr>,
#> #   touched <chr>, lastrevid <int>, length <int>, fullurl <chr>, editurl <chr>,
#> #   canonicalurl <chr>, pageid <int>, `Page creator` <chr>,
#> #   `Date of page creation` <dttm>, `Latest editor` <chr>,
#> #   `Date of latest edit` <dttm>, `Total number of edits` <chr>,
#> #   `Total number of distinct authors` <chr>,
#> #   `Recent number of edits (within past 90 days)` <chr>, …
```
