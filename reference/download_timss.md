# Download and import an empty FDZ file.

Download and import an empty TIMSS data set from the [FDZ
homepage](https://www.iqb.hu-berlin.de/fdz/studies/).

## Usage

``` r
download_timss(
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

The function downloads and imports an empty TIMSS data set
(`Leerdatensatz`) from the FDZ homepage. These data sets contain zero
rows. The data is imported via
[`import_spss`](https://beckerbenj.github.io/eatGADS/reference/import_spss.html)
as a `GADSdat` object.

## Examples

``` r
fdz_timss <- download_timss(year = "2019",
                        data_type = "stud_par_dat")
```
