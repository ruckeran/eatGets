# Download and import an empty ICILS public use file.

Download and import an empty ICILS public use file (containing only the
first data row) from the [IEA
homepage](https://www.iea.nl/data-tools/repository/icils).

## Usage

``` r
download_icils_iea(
  year = c("2018", "2013"),
  data_type = c("stud_dat", "stud_nat_dat", "stud_int_dat", "teach_dat", "teach_nat_dat",
    "teach_int_dat", "school_dat", "school_nat_dat", "school_int_dat", "it_dat")
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
For downloading full ICILS data sets see the
[EdSurvey](https://cran.r-project.org/package=EdSurvey) package. The
data is imported as a `GADSdat` object.

## Examples

``` r
if (FALSE) { # interactive()
iea_icils <- download_icils_iea(year = "2018",
                        data_type = "stud_dat")
}
```
