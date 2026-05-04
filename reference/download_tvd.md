# Download and import an empty FDZ file.

Download and import an empty TVD data set from the [FDZ
homepage](https://www.iqb.hu-berlin.de/fdz/studies/).

## Usage

``` r
download_tvd(
  data_type = c("stud_dat", "teach_dat", "teach_log_dat", "video_timss_dat", "video_dat",
    "video_subj_dat", "video_teach_dat", "video_third_dat", "artefact")
)
```

## Arguments

- data_type:

  Type of the data.

## Details

The function downloads and imports an empty TVD data set
(`Leerdatensatz`) from the FDZ homepage. These data sets contain zero
rows. The data is imported via
[`import_spss`](https://beckerbenj.github.io/eatGADS/reference/import_spss.html)
as a `GADSdat` object.

## Examples

``` r
fdz_tvd <- download_tvd(data_type = "stud_dat")
```
