
<!-- README.md is generated from README.Rmd. Please edit that file and then run `devtools::build_readme()` to render with the latest version of the code.-->

# OpenStreetMap’s tagging datasets

<!-- badges: start -->

<!-- badges: end -->

The goal of `{osmtaggingr}` is to provide reproducible datasets
containing information about [OpenStreetMap](http://openstreetmap.org)’s
tagging proposals. It does so by querying and webscrapping OSM’s wiki
via helper functions.

The package contains the following:

1.  Datasets (`proposals`) and associated metadata (see `?proposals`)
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

# Converting to tibble for better representation.
proposals <- tibble::as_tibble(proposals)

# Explore the dataset.
head(proposals)
#> # A tibble: 6 × 24
#>   title           sortkeyprefix timestamp status    ns contentmodel pagelanguage
#>   <chr>           <chr>         <chr>     <chr>  <int> <chr>        <chr>       
#> 1 Proposal:Elect… "\"electrici… 2022-03-… Rejec…  3000 wikitext     en          
#> 2 Proposal:Motor… "\"tag motor… 2022-03-… Rejec…  3000 wikitext     en          
#> 3 Proposal:Tramt… "\"Tramtrack… 2022-03-… Rejec…  3000 wikitext     en          
#> 4 Proposal:Ameni… "Amenity=lou… 2024-10-… Rejec…  3000 wikitext     en          
#> 5 Proposal:Aquat… "Aquatics ce… 2022-03-… Rejec…  3000 wikitext     en          
#> 6 Proposal:3rd a… "3rd and 4th… 2022-07-… Appro…  3000 wikitext     en          
#> # ℹ 17 more variables: pagelanguagehtmlcode <chr>, pagelanguagedir <chr>,
#> #   touched <chr>, lastrevid <int>, length <int>, fullurl <chr>, editurl <chr>,
#> #   canonicalurl <chr>, pageid <int>, `Page creator` <chr>,
#> #   `Date of page creation` <dttm>, `Latest editor` <chr>,
#> #   `Date of latest edit` <dttm>, `Total number of edits` <chr>,
#> #   `Total number of distinct authors` <chr>,
#> #   `Recent number of edits (within past 90 days)` <chr>, …

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
