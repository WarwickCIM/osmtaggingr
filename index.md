# OpenStreetMap’s tagging datasets

The goal of [osmtaggingr](https://github.com/WarwickCIM/osmtaggingr) is
to provide reproducible datasets containing information about
[OpenStreetMap](http://openstreetmap.org)’s tagging proposals. It does
so by querying and webscrapping OSM’s wiki via helper functions.

The package contains the following:

1.  Datasets (`proposals`) and associated metadata (see
    [`?proposals`](https://warwickcim.github.io/osmtaggingr/reference/proposals.md))
2.  Helper functions and description

## Acknowledgements

This is an output of the research project *[“Can digital goods be
neutral? Evaluating OpenStreetMap’s equity through participatory data
visualisation”](https://warwick.ac.uk/fac/cross_fac/cim/research/digital-good-neutrality-osm)*
led by Carlos Cámara-Menoyo and Timothy Monteath and funded by the [ESRC
Digital Good Network](https://digitalgood.net/) through their Digital
Good Research Fund 2024-25.

## Citing

You are free to use and reuse this tool under the licence conditions.  
If you use this package in your work, please cite it as below:

> Cámara-Menoyo C, Monteath T (2026). OSMtaggingR: Creates
> OpenStreetMap’s tagging Datasets. R package version 0.0.0.9000,
> <https://github.com/WarwickCIM/OSMtaggingR>.

``` bibtex
@Manual{,
  title = {OSMtaggingR: Creates OpenStreetMap's tagging Datasets},
  author = {Carlos Cámara-Menoyo and Timothy Monteath},
  year = {2026},
  note = {R package version 0.0.0.9000},
  url = {https://github.com/WarwickCIM/OSMtaggingR},
}
```

## Installation

You can install the development version of osmtaggingr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("warwickcim/osmtaggingr")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(osmtaggingr)

# Load the built in datasets.
data(proposals)

# Explore the dataset.
head(proposals)
#>                           title                                sortkeyprefix
#> 1          Proposal:Electricity                                "electricity"
#> 2  Proposal:Motorcycle friendly "tag motorcycle_friendly" for accommodations
#> 3 Proposal:Tramtrack on highway                       "Tramtrack on highway"
#> 4       Proposal:Amenity=lounge                               Amenity=lounge
#> 5      Proposal:Aquatics centre                              Aquatics centre
#> 6     Proposal:3rd and 4th rail                             3rd and 4th rail
#>              timestamp   status   ns contentmodel pagelanguage
#> 1 2022-03-15T02:38:02Z Rejected 3000     wikitext           en
#> 2 2022-03-14T20:31:57Z Rejected 3000     wikitext           en
#> 3 2022-03-15T03:40:16Z Rejected 3000     wikitext           en
#> 4 2024-10-30T16:40:54Z Rejected 3000     wikitext           en
#> 5 2022-03-14T15:18:12Z Rejected 3000     wikitext           en
#> 6 2022-07-21T11:13:48Z Approved 3000     wikitext           en
#>   pagelanguagehtmlcode pagelanguagedir              touched lastrevid length
#> 1                   en             ltr 2026-02-22T18:10:16Z   2513631  69307
#> 2                   en             ltr 2026-02-22T18:10:04Z   2515774  11731
#> 3                   en             ltr 2026-02-03T18:31:06Z   2667855  12500
#> 4                   en             ltr 2026-02-22T18:10:40Z   2771602  12681
#> 5                   en             ltr 2026-02-03T18:31:06Z   2511978  14296
#> 6                   en             ltr 2026-02-22T18:10:27Z   2511273   9553
#>                                                             fullurl
#> 1          https://wiki.openstreetmap.org/wiki/Proposal:Electricity
#> 2  https://wiki.openstreetmap.org/wiki/Proposal:Motorcycle_friendly
#> 3 https://wiki.openstreetmap.org/wiki/Proposal:Tramtrack_on_highway
#> 4     https://wiki.openstreetmap.org/wiki/Proposal:Amenity%3Dlounge
#> 5      https://wiki.openstreetmap.org/wiki/Proposal:Aquatics_centre
#> 6     https://wiki.openstreetmap.org/wiki/Proposal:3rd_and_4th_rail
#>                                                                                      editurl
#> 1          https://wiki.openstreetmap.org/w/index.php?title=Proposal:Electricity&action=edit
#> 2  https://wiki.openstreetmap.org/w/index.php?title=Proposal:Motorcycle_friendly&action=edit
#> 3 https://wiki.openstreetmap.org/w/index.php?title=Proposal:Tramtrack_on_highway&action=edit
#> 4     https://wiki.openstreetmap.org/w/index.php?title=Proposal:Amenity%3Dlounge&action=edit
#> 5      https://wiki.openstreetmap.org/w/index.php?title=Proposal:Aquatics_centre&action=edit
#> 6     https://wiki.openstreetmap.org/w/index.php?title=Proposal:3rd_and_4th_rail&action=edit
#>                                                        canonicalurl pageid
#> 1          https://wiki.openstreetmap.org/wiki/Proposal:Electricity 205062
#> 2  https://wiki.openstreetmap.org/wiki/Proposal:Motorcycle_friendly 177232
#> 3 https://wiki.openstreetmap.org/wiki/Proposal:Tramtrack_on_highway 215012
#> 4     https://wiki.openstreetmap.org/wiki/Proposal:Amenity%3Dlounge 322252
#> 5      https://wiki.openstreetmap.org/wiki/Proposal:Aquatics_centre 154289
#> 6     https://wiki.openstreetmap.org/wiki/Proposal:3rd_and_4th_rail 252781
#>    Page creator Date of page creation Latest editor Date of latest edit
#> 1 Privatemajory   2018-09-03 15:51:00  TigerfellBot 2023-04-30 15:12:00
#> 2          Rtfm   2017-01-10 12:50:00  TigerfellBot 2023-04-30 16:55:00
#> 3     Tolstoi21   2018-11-01 11:48:00        Maro21 2024-02-21 20:31:00
#> 4         Lega4   2024-10-07 13:49:00         Lega4 2024-10-30 16:40:00
#> 5      Math1985   2015-12-25 19:42:00  TigerfellBot 2023-04-30 13:55:00
#> 6       GazzerK   2020-06-07 11:09:00  TigerfellBot 2023-04-29 21:59:00
#>   Total number of edits Total number of distinct authors
#> 1                   220                               53
#> 2                    65                               27
#> 3                    50                               22
#> 4                    27                               14
#> 5                    77                               48
#> 6                    68                               30
#>   Recent number of edits (within past 90 days)
#> 1                                            0
#> 2                                            0
#> 3                                            0
#> 4                                            0
#> 5                                            0
#> 6                                            0
#>   Recent number of distinct authors
#> 1                                 0
#> 2                                 0
#> 3                                 0
#> 4                                 0
#> 5                                 0
#> 6                                 0

colnames(proposals)
#>  [1] "title"                                       
#>  [2] "sortkeyprefix"                               
#>  [3] "timestamp"                                   
#>  [4] "status"                                      
#>  [5] "ns"                                          
#>  [6] "contentmodel"                                
#>  [7] "pagelanguage"                                
#>  [8] "pagelanguagehtmlcode"                        
#>  [9] "pagelanguagedir"                             
#> [10] "touched"                                     
#> [11] "lastrevid"                                   
#> [12] "length"                                      
#> [13] "fullurl"                                     
#> [14] "editurl"                                     
#> [15] "canonicalurl"                                
#> [16] "pageid"                                      
#> [17] "Page creator"                                
#> [18] "Date of page creation"                       
#> [19] "Latest editor"                               
#> [20] "Date of latest edit"                         
#> [21] "Total number of edits"                       
#> [22] "Total number of distinct authors"            
#> [23] "Recent number of edits (within past 90 days)"
#> [24] "Recent number of distinct authors"

# Check the dataset's metadata
?proposals
```
