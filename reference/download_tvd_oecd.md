# Download and import an empty TVD public use file.

Download and import an empty TVD public use file (containing only the
first data row) from the [OECD
homepage](https://www.oecd.org/en/data/datasets/).

## Usage

``` r
download_tvd_oecd(
  data_type = c("stud_dat", "teach_dat", "teach_log_dat", "video_timss_dat", "video_dat",
    "video_subj_dat", "video_teach_dat", "video_third_dat", "artefact")
)
```

## Arguments

- data_type:

  Type of the data.

## Details

The function downloads a zip file from the OECD homepage into a
temporary directory, unzips it and imports the data with only a single
data row via [`read.csv`](https://rdrr.io/r/utils/read.table.html). For
downloading full TVD data sets see the
[EdSurvey](https://cran.r-project.org/package=EdSurvey) package. The
data is imported as a `GADSdat` object.

## Examples

``` r
if (FALSE) { # interactive()
oecd_tvd <- download_tvd_oecd(data_type = "stud_dat")
}
```
