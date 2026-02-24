# Retrieve a list of tagging proposals

This function retrieves all tagging proposals in OSM's wiki by querying
mediawiki's API

## Usage

``` r
get_tagging_proposals(
  statuses = c("Rejected", "Approved", "Proposed"),
  details = TRUE,
  max_items = 5,
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

- file:

  a string containing the file path to store the dataset.

## Value

a dataframe containing tagging proposals and associated metadata
(`title`, `sortkeyprefix`, `timestamp`, `status`, `int`, `ns`,
`contentmodel`, `pagelanguage`, `pagelanguagehtmlcode`,
`pagelanguagedir`, `touched`, `lastrevid`, `length`, `fullurl`,
`editurl`, `canonicalurl`, `pageid`).

## Examples

``` r
proposals <- get_tagging_proposals("Proposed")
head(proposals)
#>                                             title
#> 1    Proposal:3D tagging for building base shapes
#> 2                            Proposal:Note suffix
#> 3                             Proposal:Access key
#> 4 Proposal:Add languages: tags for name rendering
#> 5                          Proposal:Addr:interval
#>                                 sortkeyprefix            timestamp   status int
#> 1         3D tagging for building base shapes 2025-09-06T17:57:58Z Proposed  NA
#> 2                                :note suffix 2022-07-12T09:33:14Z Proposed  NA
#> 3                                  access_key 2024-10-15T12:03:14Z Proposed  NA
#> 4      Add languages: tags for name rendering 2024-11-13T09:49:37Z Proposed  NA
#> 5 addr:interpolation on closed ways and nodes 2022-03-15T14:59:09Z Proposed  NA
#>     ns contentmodel pagelanguage pagelanguagehtmlcode pagelanguagedir
#> 1 3000     wikitext           en                   en             ltr
#> 2 3000     wikitext           en                   en             ltr
#> 3 3000     wikitext           en                   en             ltr
#> 4 3000     wikitext           en                   en             ltr
#> 5 3000     wikitext           en                   en             ltr
#>                touched lastrevid length
#> 1 2026-02-03T18:31:06Z   2923402  14917
#> 2 2026-02-03T18:31:06Z   2511257   4566
#> 3 2026-02-03T18:31:06Z   2767048   4331
#> 4 2026-02-03T18:31:06Z   2792396  22391
#> 5 2026-02-03T18:31:06Z   2511609   7462
#>                                                                               fullurl
#> 1    https://wiki.openstreetmap.org/wiki/Proposal:3D_tagging_for_building_base_shapes
#> 2                            https://wiki.openstreetmap.org/wiki/Proposal:Note_suffix
#> 3                             https://wiki.openstreetmap.org/wiki/Proposal:Access_key
#> 4 https://wiki.openstreetmap.org/wiki/Proposal:Add_languages:_tags_for_name_rendering
#> 5                          https://wiki.openstreetmap.org/wiki/Proposal:Addr:interval
#>                                                                                                        editurl
#> 1    https://wiki.openstreetmap.org/w/index.php?title=Proposal:3D_tagging_for_building_base_shapes&action=edit
#> 2                            https://wiki.openstreetmap.org/w/index.php?title=Proposal:Note_suffix&action=edit
#> 3                             https://wiki.openstreetmap.org/w/index.php?title=Proposal:Access_key&action=edit
#> 4 https://wiki.openstreetmap.org/w/index.php?title=Proposal:Add_languages:_tags_for_name_rendering&action=edit
#> 5                          https://wiki.openstreetmap.org/w/index.php?title=Proposal:Addr:interval&action=edit
#>                                                                          canonicalurl
#> 1    https://wiki.openstreetmap.org/wiki/Proposal:3D_tagging_for_building_base_shapes
#> 2                            https://wiki.openstreetmap.org/wiki/Proposal:Note_suffix
#> 3                             https://wiki.openstreetmap.org/wiki/Proposal:Access_key
#> 4 https://wiki.openstreetmap.org/wiki/Proposal:Add_languages:_tags_for_name_rendering
#> 5                          https://wiki.openstreetmap.org/wiki/Proposal:Addr:interval
#>   pageid
#> 1 331041
#> 2 286463
#> 3 322472
#> 4 323259
#> 5 259310
```
