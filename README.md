
<!-- README.md is generated from README.Rmd. Please edit that file and then run `devtools::build_readme()` to render with the latest version of the code.-->

# OpenStreetMap’s tagging datasets

<!-- badges: start -->

<!-- badges: end -->

The goal of osmtaggingr is to generate datasets containing information
about [OpenStreetMap](http://openstreetmap.org)’s tagging proposals.

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

head(proposals)
#>                           title                                sortkeyprefix
#> 1          Proposal:Electricity                                "electricity"
#> 2  Proposal:Motorcycle friendly "tag motorcycle_friendly" for accommodations
#> 3 Proposal:Tramtrack on highway                       "Tramtrack on highway"
#> 4       Proposal:Amenity=lounge                               Amenity=lounge
#> 5      Proposal:Aquatics centre                              Aquatics centre
#> 6        Approved features/2006                                         2006
#>              timestamp   status int   ns contentmodel pagelanguage
#> 1 2022-03-15T02:38:02Z Rejected  NA 3000     wikitext           en
#> 2 2022-03-14T20:31:57Z Rejected  NA 3000     wikitext           en
#> 3 2022-03-15T03:40:16Z Rejected  NA 3000     wikitext           en
#> 4 2024-10-30T16:40:54Z Rejected  NA 3000     wikitext           en
#> 5 2022-03-14T15:18:12Z Rejected  NA 3000     wikitext           en
#> 6 2017-11-25T14:40:16Z Approved  NA    0     wikitext           en
#>   pagelanguagehtmlcode pagelanguagedir              touched lastrevid length
#> 1                   en             ltr 2026-02-22T18:10:16Z   2513631  69307
#> 2                   en             ltr 2026-02-22T18:10:04Z   2515774  11731
#> 3                   en             ltr 2026-02-03T18:31:06Z   2667855  12500
#> 4                   en             ltr 2026-02-22T18:10:40Z   2771602  12681
#> 5                   en             ltr 2026-02-03T18:31:06Z   2511978  14296
#> 6                   en             ltr 2023-01-15T10:41:01Z   1555014   1429
#>                                                             fullurl
#> 1          https://wiki.openstreetmap.org/wiki/Proposal:Electricity
#> 2  https://wiki.openstreetmap.org/wiki/Proposal:Motorcycle_friendly
#> 3 https://wiki.openstreetmap.org/wiki/Proposal:Tramtrack_on_highway
#> 4     https://wiki.openstreetmap.org/wiki/Proposal:Amenity%3Dlounge
#> 5      https://wiki.openstreetmap.org/wiki/Proposal:Aquatics_centre
#> 6        https://wiki.openstreetmap.org/wiki/Approved_features/2006
#>                                                                                      editurl
#> 1          https://wiki.openstreetmap.org/w/index.php?title=Proposal:Electricity&action=edit
#> 2  https://wiki.openstreetmap.org/w/index.php?title=Proposal:Motorcycle_friendly&action=edit
#> 3 https://wiki.openstreetmap.org/w/index.php?title=Proposal:Tramtrack_on_highway&action=edit
#> 4     https://wiki.openstreetmap.org/w/index.php?title=Proposal:Amenity%3Dlounge&action=edit
#> 5      https://wiki.openstreetmap.org/w/index.php?title=Proposal:Aquatics_centre&action=edit
#> 6        https://wiki.openstreetmap.org/w/index.php?title=Approved_features/2006&action=edit
#>                                                        canonicalurl pageid
#> 1          https://wiki.openstreetmap.org/wiki/Proposal:Electricity 205062
#> 2  https://wiki.openstreetmap.org/wiki/Proposal:Motorcycle_friendly 177232
#> 3 https://wiki.openstreetmap.org/wiki/Proposal:Tramtrack_on_highway 215012
#> 4     https://wiki.openstreetmap.org/wiki/Proposal:Amenity%3Dlounge 322252
#> 5      https://wiki.openstreetmap.org/wiki/Proposal:Aquatics_centre 154289
#> 6        https://wiki.openstreetmap.org/wiki/Approved_features/2006  55725

colnames(proposals)
#>  [1] "title"                "sortkeyprefix"        "timestamp"           
#>  [4] "status"               "int"                  "ns"                  
#>  [7] "contentmodel"         "pagelanguage"         "pagelanguagehtmlcode"
#> [10] "pagelanguagedir"      "touched"              "lastrevid"           
#> [13] "length"               "fullurl"              "editurl"             
#> [16] "canonicalurl"         "pageid"

# Check the dataset's metadata
?proposals
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

`r pressure, echo = FALSE} plot(pressure)`

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
