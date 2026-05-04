# Download and import an empty TIMSS public use file.

Download and import an empty TIMSS public use file (containing only the
first data row) from the [IEA
homepage](https://www.iea.nl/data-tools/repository/icils).

## Usage

``` r
download_timss_iea(
  year = c("2019", "2015", "2011", "2007"),
  data_type = c("stud_par_dat", "teach_dat", "teach_stud_dat", "school_dat", "tracking")
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
For downloading full TIMSS data sets see the
[EdSurvey](https://cran.r-project.org/package=EdSurvey) package. The
data is imported as a `GADSdat` object.

## Examples

``` r
if (FALSE) { # interactive()
iea_timss <- download_timss_iea(year = "2019",
                        data_type = "stud_par_dat")
}
```
