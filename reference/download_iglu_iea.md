# Download and import an empty IGLU public use file.

Download and import an empty IGLU public use file (containing only the
first data row) from the [IEA
homepage](https://www.iea.nl/data-tools/repository/pirls).

## Usage

``` r
download_iglu_iea(
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

The function downloads a zip file from the IEA homepage into a temporary
directory, unzips it and imports the data with only a single data row
via [`read_sav`](https://haven.tidyverse.org/reference/read_spss.html).
For downloading full IGLU data sets see the
[EdSurvey](https://cran.r-project.org/package=EdSurvey) package. The
data is imported as a `GADSdat` object.

## Examples

``` r
if (FALSE) { # interactive()
iea_iglu <- download_iglu_iea(year = "2016",
                        data_type = "stud_par_dat")
}
```
