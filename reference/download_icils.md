# Download and import an empty FDZ file.

Download and import an empty ICILS data set from the [FDZ
homepage](https://www.iqb.hu-berlin.de/fdz/studies/).

## Usage

``` r
download_icils(
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

The function downloads and imports an empty ICILS data set
(`Leerdatensatz`) from the FDZ homepage. These data sets contain zero
rows. The data is imported via
[`import_spss`](https://beckerbenj.github.io/eatGADS/reference/import_spss.html)
as a `GADSdat` object.

## Examples

``` r
fdz_icils <- download_icils(year = "2018",
                        data_type = "stud_dat")
```
