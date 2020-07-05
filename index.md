# ritwals - R Interface to WALS

`ritwals` is an R package that provides an intuitive interface to the [World Atlas of Language Structures](http://wals.info). The WALS data is (re)distributed with the package (i.e. web access is not required to use it).


## Installation

```r
install.packages("devtools") # if you do not have devtools
devtools::install_github("hkauhanen/ritwals")
```

## Documentation

See [function reference](reference/index.html) (vignettes are in preparation).


## Legal

Portions of this package constitute a derivative work of the World Atlas of Language Structures (Dryer & Haspelmath 2013); see [DESCRIPTION](https://github.com/hkauhanen/ritwals/blob/master/DESCRIPTION).

Semantically, the WALS has not been changed upon incorporation into this software package. What has been done is to collate all the various data files WALS provides (on languages, on features, on geographical information...) into a single data frame that supplies the entire atlas in one place, and enhance this with functions that assist in accessing the atlas data.


## Reference

Dryer, Matthew S. & Haspelmath, Martin (eds.) 2013. The World Atlas of Language Structures Online. Leipzig: Max Planck Institute for Evolutionary Anthropology. <http://wals.info>

