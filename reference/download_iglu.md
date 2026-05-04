# Download and import an empty FDZ file.

Download and import an empty IGLU data set from the [FDZ
homepage](https://www.iqb.hu-berlin.de/fdz/studies/).

## Usage

``` r
download_iglu(
  year = c("2016", "2011", "2006", "2001"),
  data_type = c("stud_par_dat", "teach_ger_dat", "teach_math_dat", "teach_gen_dat",
    "teach_dat", "teach_stud_dat", "school_dat", "tracking", "testscores")
)
```

## Arguments

- year:

  Year of the assessment.

- data_type:

  Type of the data.

## Details

The function downloads and imports an empty IGLU data set
(`Leerdatensatz`) from the FDZ homepage. These data sets contain zero
rows. The data is imported via
[`import_spss`](https://beckerbenj.github.io/eatGADS/reference/import_spss.html)
as a `GADSdat` object.

## Examples

``` r
fdz_iglu <- download_iglu(year = "2016",
                        data_type = "stud_par_dat")
#> Warning: Some values with value labels or missing tags of variable TR_ARBEITSV cannot be coerced to numeric and are therefore changed to NA. For other import behavior check out the 'labeledStrings' argument.
#> Warning: Some values with value labels or missing tags of variable TR_SOZIALV cannot be coerced to numeric and are therefore changed to NA. For other import behavior check out the 'labeledStrings' argument.
#> Warning: Some values with value labels or missing tags of variable ITDATE_FDZ cannot be coerced to numeric and are therefore changed to NA. For other import behavior check out the 'labeledStrings' argument.
#> Warning: Duplicate value labels or missing tags are dropped for variable 'TR_ARBEITSV'. Only the respective first value label or missing tag is preserved and zero-decimals are dropped.
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: Duplicate value labels or missing tags are dropped for variable 'TR_SOZIALV'. Only the respective first value label or missing tag is preserved and zero-decimals are dropped.
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: Corrupted missing values haven been found in variable ITDATE_FDZ and are dropped. Contact package author for further information. The affected values are:NA
```
