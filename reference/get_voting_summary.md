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

a dataframe with the following columns:

- `url`: the URL of the tagging proposal.

- `proposal_status`: the status of the proposal.

- `proposed_by`: name of the user(s) making the proposal.

- `tagging`: proposed tagging scheme.

- `applies_to`: which geospatial features can this feature be applied
  to.

- `definition`: a short definition of what the tagging proposal aims to
  describe.

- `statistics`: usage statistics, from
  [taginfo](https://taginfo.geofabrik.de/).

- `rendered_as`: whether the feature has an icon or not.

- `draft_started`: date in which the proposal draft started.

- `rfc_start`: date in which Request For Comments (RFC) started.

- `vote_start`: date in which the voting process started.

- `vote_end`: date in which the voting process ended.

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
