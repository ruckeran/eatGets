# Download and import an empty FDZ file.

Download and import an empty PISA data set from the [FDZ
homepage](https://www.iqb.hu-berlin.de/fdz/studies/).

## Usage

``` r
download_pisa(
  year = c("2018", "2015", "2012", "2009", "2006", "2003", "2000"),
  data_type = c("stud_dat_9kl", "stud_dat_15j", "stud_par_dat", "stud_par_dat_9kl",
    "stud_par_dat_15j", "par_dat", "par_dat_9kl", "par_dat_15j", "teach_dat",
    "teach_dat_9kl", "teach_dat_15j", "school_dat", "school_dat_9kl", "school_dat_15j",
    "matching", "timing")
)
```

## Arguments

- year:

  Year of the assessment.

- data_type:

  Type of the data.

## Details

The function downloads and imports an empty PISA data set
(`Leerdatensatz`) from the FDZ homepage. These data sets contain zero
rows. The data is imported via
[`import_spss`](https://beckerbenj.github.io/eatGADS/reference/import_spss.html)
as a `GADSdat` object.

## Examples

``` r
fdz_pisa <- download_pisa(year = "2018",
                        data_type = "stud_par_dat_9kl")
```
